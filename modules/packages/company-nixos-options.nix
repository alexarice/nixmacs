{ config, lib, ... }:

with lib;

{
  config.package.company-nixos-options.use-package.defer = mkDefault true;
}
