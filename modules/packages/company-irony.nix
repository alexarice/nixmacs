{ config, lib, pkgs, ... }:

with lib;

{
  config.package.company-irony = {
    defer = mkDefault true;
    external-packages = mkDefault [ pkgs.clang ];
  };
}
