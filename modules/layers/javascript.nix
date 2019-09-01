{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.layers.javascript;
in
{
  options.layers.javascript.enable = mkEnableOption "javascript layer";

  config = mkIf cfg.enable {
    package = {
      js2-mode.enable = true;
      js2-refactor.enable = true;
      company-tern.enable = config.package.company.enable;
      flycheck = {
        settings.disabled-checkers = [ "javascript-jshint" ];
        external-packages = [ pkgs.nodePackages.eslint ];
      };
    };

    layers.completion.company-hooks.js2-mode = [ "company-tern" "(company-dabbrev-code company-capf)" ];
  };
}
