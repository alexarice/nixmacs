{ config, lib, ... }:

with lib;

let
  cfg = config.layers.haskell;
in
{
  options.layers.haskell = {
    enable = mkEnableOption "haskell layer";
  };

  config = mkIf cfg.enable {
    package = {
      haskell-mode.enable = true;
      hlint-refactor.enable = true;
      dante.enable = true;
      company.settings.company-hooks.haskell-mode = mkDefault [
         "dante-company"
         "company-ddabrev-code"
      ];
    };
  };
}
