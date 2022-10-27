{ config, lib, ... }:

with lib;

let
  cfg = config.layers.lsp;
in
{
  options.layers.lsp = {
    enable = mkEnableOption "Language Server Protocol Layer";

    ui = mkEnableOption "lsp-ui mode";
  };

  config = mkIf cfg.enable {
    package = {
      lsp-mode.enable = mkDefault true;

      lsp-ui.enable = mkDefault cfg.ui;

      lsp-ivy.enable = mkDefault config.layers.ivy.enable;
    };
  };
}
