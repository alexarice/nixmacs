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
      flycheck-rust.enable = mkDefault true;
      rust-mode.enable = mkDefault true;
      racer.enable = mkDefault false;
      toml-mode.enable = mkDefault true;
      cargo.enable = mkDefault true;

      company.settings.company-hooks.rust-mode = [
        "company-capf"
        "company-dabbrev-code"
      ];
    };
  };
}
