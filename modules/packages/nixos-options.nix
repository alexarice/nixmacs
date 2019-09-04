{ config, lib, ... }:

with lib;

{
  package.nixos-options.use-package.defer = mkDefault true;
}
