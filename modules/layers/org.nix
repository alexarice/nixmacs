{ config, lib, ... }:

with lib;

let
  cfg = config.layers.org;
in
{
  options.layers.org = {
    enable = mkEnableOption "org layer";

    agenda-files = mkOption {
      type = with types; either path (listOf path);
      default = [];
      description = ''
        List of paths to add to org-agenda-files or a file containing
        a list of files within it.
      '';
    };
  };

  config = mkIf cfg.enable {
    package.org-bullets.enable = mkDefault true;

    settings.global-variables.org-agenda-files = if isList cfg.agenda-files then ''
      '(${concatStringsSep " " (map (x: ''"${toString x}"'') cfg.agenda-files)})
    '' else ''
      "${toString cfg.agenda-files}"
    '';
  };
}
