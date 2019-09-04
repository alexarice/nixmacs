{ config, lib, epkgs, ... }:

with lib;

{
  package.anaconda-eldoc-mode = {
    package = mkDefault epkgs.anaconda-mode;
    use-package.hook = mkDefault "python-mode";
  };
}
