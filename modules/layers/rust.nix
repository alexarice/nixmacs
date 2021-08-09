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
      # flycheck-rust.enable = mkDefault true;
      rustic.enable = mkDefault true;
      toml-mode.enable = mkDefault true;
      cargo.enable = mkDefault true;

      company.settings.company-hooks.rust-mode = [
        "company-lsp"
        "company-capf"
        "company-dabbrev-code"
      ];
    };
  };
}
