{ config, lib, ... }:

with lib;

{
  package.company-nixos-options.use-package.defer = mkDefault true;
}
