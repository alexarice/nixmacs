{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.package.org-roam.settings;
in
{
  options.package = add-settings "org-roam" {
    directory = mkOption {
      type = types.str;
      description = ''
        Directory for org roam
      '';
    };
  };

  config.package.org-roam = {
    external-packages = [ pkgs.sqlite ];
    use-package = {
      hook = mkDefault "(after-init . org-roam-mode)";
      custom.org-roam-directory = mkDefault ''"${cfg.directory}"'';
    };
  };
}
