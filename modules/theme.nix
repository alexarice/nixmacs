{ config, lib, ... }:

with lib;

let
  cfg = config.appearance.theme;
in
{
  options = {
    appearance = {
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
          defaultText = literalExample "config.appearance.theme.package.pname";
          description = ''
            theme name to be put in init-el
          '';
        };
      };
    };
  };

  config = mkIf cfg.enable {
    package."${cfg.package.pname}" = {
      enable = true;
      inherit (cfg) package;
      use-package.config = "(load-theme '${cfg.themeName} t)";
    };
  };
}
