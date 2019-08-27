{ config, lib, ... }:

with lib;

{
  config.package.company-nixos-options.defer = mkDefault true;
}
