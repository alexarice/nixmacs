{ config, lib, ... }:

with lib;

let
  cfg = config.package.flycheck.settings;
in
{
  options.package.flycheck.settings = {
    disabled-checkers = mkOption {
      type = with types; listOf str;
      default = [];
      description = ''
        Checkers to be added to flycheck-disabled-checkers
      '';
    };
  };

  config.package.flycheck.use-package = {
    config = mkDefault "(global-flycheck-mode)";
    custom.flycheck-disabled-checkers = "'(${concatStringsSep " " cfg.disabled-checkers})";
  };
}
