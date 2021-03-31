{ config, lib, ... }:

with lib;

let
  cfg = config.layers.haskell;
  cfg-lsp = config.package.lsp-mode.enable;
in
{
  options.layers.haskell = {
    enable = mkEnableOption "haskell layer";
  };

  config = mkIf cfg.enable {
    package = {
      haskell-mode.enable = true;
      hlint-refactor.enable = true;
      lsp-haskell = {
        enable = mkIf cfg-lsp true;
      };
      lsp-mode.settings.lsp-hooks = mkIf cfg-lsp [ "haskell-mode" ];
      company.settings.company-hooks.haskell-mode = mkDefault (
        optional cfg-lsp "company-lsp" ++ [
          "(company-capf :with company-dabbrev-code)"
          "company-dabbrev-code"
        ]);
    };
  };
}
