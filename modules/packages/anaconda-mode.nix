{ config, lib, ... }:

with lib;

{
  package.anaconda-mode.use-package.hook = mkDefault "python-mode";
}
