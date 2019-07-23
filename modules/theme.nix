{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.theme;
in
{
  options = {
    theme = {
      enable = mkEnableOption "Theme";

      package = mkOption {
        type = types.package;
        description = ''
          emacs package for theme
        '';
      };

      themeName = mkOption {
        type = types.str;
        default = cfg.package.pname;
        description = ''
          theme name to be put in init-el
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    packages."${cfg.package.pname}" = {
      enable = true;
      inherit (cfg) package;
      config = "(load-theme '${cfg.themeName} t)";
    };
  };
}
