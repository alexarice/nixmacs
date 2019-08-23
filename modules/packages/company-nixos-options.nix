{ config, lib, ... }:

with lib;

{
  config.use-package.company-nixos-options.defer = mkDefault true;
}
