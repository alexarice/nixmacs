{ lib, ... }:

with lib;

{
  package.proof-general.use-package.defer = mkDefault true;
}
