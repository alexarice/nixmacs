{ config, lib, ... }:

with lib;

let
  cfg = config.layers.rust;
in
{
  options.layers.rust = {
    enable = mkEnableOption "rust layer";
  };

  config = mkIf cfg.enable {
    package = {
      flycheck-rust.enable = true;
      rust-mode.enable = true;
      racer.enable = true;
      toml-mode.enable = true;
      cargo.enable = true;

      company.settings.company-hooks.rust-mode = [
        "company-capf"
        "company-dabbrev-code"
      ];
    };
  };
}
