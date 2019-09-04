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
        Amount of indent in javascript modes
      '';
    };
  };

  config = mkIf cfg.enable {
    package = {
      js2-mode = {
        enable = true;
        use-package.custom.js-indent-level = cfg.indent-level;
      };
      js2-refactor.enable = true;
      company-tern.enable = config.package.company.enable;
      company.settings.company-hooks.js2-mode = [ "company-tern" "(company-dabbrev-code company-capf)" ];
      flycheck = {
        settings.disabled-checkers = [ "javascript-jshint" ];
        external-packages = [ pkgs.nodePackages.eslint ];
      };
    };
  };
}
