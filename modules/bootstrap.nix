{ config, pkgs, ... }:

{
  config = {
    rawPackageList = [ pkgs.emacsPackagesNg.melpaStablePackages.use-package ];

    init-el.preamble = ''
      (eval-when-compile
        (require 'use-package))
    '';
  };
}
