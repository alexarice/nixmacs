{ config, lib, ... }:

with lib;

{
  config.package.nixos-options.use-package.defer = mkDefault true;
}
