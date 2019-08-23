{ config, lib, ... }:

with lib;

{
  config.use-package.nixos-options.defer = mkDefault true;
}
