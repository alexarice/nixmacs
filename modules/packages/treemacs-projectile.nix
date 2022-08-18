{ config, lib, pkgs, ... }:

with lib;

{
  package.treemacs-projectile.use-package = {
    after = [ "treemacs" "projectile" ];
  };
}
