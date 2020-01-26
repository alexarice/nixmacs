{ config, lib, ... }:

with lib;

let
  cfg = config.layers.haskell;
  cfg-lsp = config.package.lsp-mode.enable;
in
{
  options.layers.haskell = {
    enable = mkEnableOption "haskell layer";

    hies = mkOption {
      type = with types; nullOr package;
      default = null;
      description = ''
        Haskell-ide-engine package to install.
      '';
    };
  };

  config = mkIf cfg.enable {
    package = {
      haskell-mode.enable = true;
      hlint-refactor.enable = true;
      lsp-haskell = {
        enable = mkIf cfg-lsp true;
        external-packages = mkIf (cfg.hies != null) [ cfg.hies ];
      };
      company-lsp.enable = mkIf cfg-lsp (mkDefault true);
      lsp-mode.settings.lsp-hooks = mkIf cfg-lsp [ "haskell-mode" ];
      company.settings.company-hooks.haskell-mode = mkDefault (
        optional cfg-lsp "company-lsp" ++ [
          "(company-capf :with company-dabbrev-code)"
          "company-dabbrev-code"
        ]);
    };
  };
}
