{ config, lib, pkgs, ... }:

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
    package = {
      org-bullets.enable = true;
      ox-publish.enable = true;
      org = {
        enable = true;
        external-packages = [ pkgs.imagemagick ];
      };
    };

    settings.global-variables = {
      org-preview-latex-default-process = "'imagemagick";
      org-agenda-files = if isList cfg.agenda-files then ''
        '(${concatStringsSep " " (map (x: ''"${toString x}"'') cfg.agenda-files)})
      '' else ''
        "${toString cfg.agenda-files}"
      '';
    };

    keybindings.major-mode.org-mode = mkDefault {
      "a" = "org-agenda-list";
      "t" = "org-todo";
      "c" = if config.layers.ivy.enable then "counsel-org-capture" else "org-capture";
      "s" = "org-sort";
      "p" = "org-toggle-latex-fragment";
    };
  };
}
