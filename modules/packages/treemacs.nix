{ config, lib, pkgs, ... }:

with lib;

{
  package.treemacs = {
    use-package = {
      custom = {
        treemacs-no-png-images = true;
        treemacs-width = 24;
      };
      commands = [ "treemacs" "treemacs-find-file" ];
    };
    external-packages = [ pkgs.python3 ];
  };
}
