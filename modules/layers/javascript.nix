{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.layers.javascript;
in
{
  options.layers.javascript = {
    enable = mkEnableOption "javascript layer";

    indent-level = mkOption {
      type = types.ints.positive;
      default = 2;
      description = ''
        Amount of indent in javascript modes.
      '';
    };
  };

  config = mkIf cfg.enable {
    package = {
      js2-mode = {
        enable = mkDefault true;
        use-package.custom.js-indent-level = mkDefault cfg.indent-level;
      };
      js2-refactor.enable = mkDefault true;
      company-tern.enable = mkDefault config.package.company.enable;
      company.settings.company-hooks.js2-mode = mkDefault [
        "company-tern"
        "(company-dabbrev-code company-capf)"
      ];
      flycheck = {
        settings.disabled-checkers = mkDefault [ "javascript-jshint" ];
        external-packages = mkDefault [ pkgs.nodePackages.eslint ];
      };
    };
  };
}
