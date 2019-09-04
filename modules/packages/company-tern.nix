{ config, lib, pkgs, ... }:

with lib;

{
  package.company-tern = {
    external-packages = mkDefault [ pkgs.nodePackages.tern ];
    use-package.hook = mkDefault "(js2-mode . tern-mode)";
  };
}
