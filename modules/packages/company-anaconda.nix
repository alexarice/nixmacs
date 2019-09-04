{ config, lib, ... }:

with lib;

{
  package.company-anaconda.use-package.defer = mkDefault true;
}
