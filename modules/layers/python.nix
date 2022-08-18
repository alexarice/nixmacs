{ config, lib, ... }:

with lib;

let
  cfg = config.layers.python;
  cfg-lsp = config.package.lsp-mode.enable;
in
{
  options.layers.python.enable = mkEnableOption "python layer";

  config = mkIf cfg.enable {
    package = {
      python.enable = mkDefault true;
      lsp-pyright.enable = mkIf cfg-lsp true;
      lsp-mode.settings.lsp-hooks = mkIf cfg-lsp [ "python-mode" ];
      company.settings.company-hooks.python-mode = mkDefault [
        "company-lsp"
        "company-dabbrev-code"
      ];
    };
  };
}
