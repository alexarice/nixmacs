{ config, epkgs, ... }:

{
  config = {
    rawPackageList = with epkgs.melpaStablePackages; [ use-package diminish ] ++ [ epkgs.elpaPackages.delight ];

    init-el.preamble = ''
      (eval-when-compile
        (require 'use-package))

      (require 'diminish)
      (require 'delight)
    '';
  };
}
