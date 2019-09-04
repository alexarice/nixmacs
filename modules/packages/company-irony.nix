{ config, lib, pkgs, ... }:

with lib;

{
  package.company-irony = {
    use-package.defer = mkDefault true;
    external-packages = mkDefault [ pkgs.clang ];
  };
}
