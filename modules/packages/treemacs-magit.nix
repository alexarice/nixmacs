{ config, lib, pkgs, ... }:

with lib;

{
  package.treemacs-magit.use-package = {
    after = [ "treemacs" "magit" ];
  };
}
