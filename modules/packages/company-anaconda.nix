{ config, lib, ... }:

with lib;

{
  config.package.company-anaconda.use-package.defer = mkDefault true;
}
