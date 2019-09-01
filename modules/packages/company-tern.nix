{ config, lib, pkgs, ... }:

with lib;

{
  config.package.company-tern = {
    external-packages = mkDefault [ pkgs.nodePackages.tern ];
    use-package.hook = mkDefault "(js2-mode . tern-mode)";
  };
}
