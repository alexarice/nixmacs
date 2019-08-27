{ config, lib, ... }:

with lib;

{
  config.package.nixos-options.defer = mkDefault true;
}
