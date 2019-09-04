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
          example = literalExample "${epkgs.dracula-theme}";
          description = ''
            Emacs package for theme.
          '';
        };

        themeName = mkOption {
          type = types.str;
          default = cfg.package.pname;
          defaultText = literalExample "config.appearance.theme.package.pname";
          example = "dracula";
          description = ''
            Theme name to load in init-el.
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
