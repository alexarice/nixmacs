{ config, pkgs, ... }:

{
  config = {
    rawPackageList = with pkgs.emacsPackagesNg.melpaStablePackages; [ use-package diminish ] ++ [pkgs.emacsPackagesNg.elpaPackages.delight];

    init-el.preamble = ''
      (eval-when-compile
        (require 'use-package))

      (require 'diminish)
      (require 'delight)
    '';
  };
}
