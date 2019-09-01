{ config, lib, ... }:

with lib;

{
  config.package.anaconda-mode.use-package.hook = mkDefault "python-mode";
}
