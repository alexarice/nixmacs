{ config, lib, epkgs, ... }:

with lib;

{
  config.package.anaconda-eldoc-mode = {
    package = mkDefault epkgs.anaconda-mode;
    use-package.hook = mkDefault "python-mode";
  };
}
