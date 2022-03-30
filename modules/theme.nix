{ config, lib, epkgs, ... }:

with lib;

let
  cfg = config.appearance.theme;
in
{
  options = {
    appearance = {
      theme = {
        enable = mkEnableOption "theme";

        package = mkOption {
          type = types.package;
          example = literalExpression "${epkgs.dracula-theme}";
          description = ''
            Emacs package for theme.
          '';
        };

        themeName = mkOption {
          type = types.str;
          default = cfg.package.pname;
          defaultText = literalExpression "config.appearance.theme.package.pname";
          example = "dracula";
          description = ''
            Theme name to load in init-el.
          '';
        };

        extraConfig = mkOption {
          type = types.lines;
          default = "";
          description = ''
            Extra config to be added to the theme package.
          '';
        };
      };
    };
  };

  config = mkIf cfg.enable {
    package."${cfg.package.pname}" = {
      enable = true;
      inherit (cfg) package;
      use-package.config = ''
        (load-theme '${cfg.themeName} t)
        ${cfg.extraConfig}
      '';
    };
  };
}
