{ config, epkgs, lib, ... }:

with lib;
{
  config = let
    packages = attrValues config.package;
    useDiminish = any (x: x.diminish != null) packages;
    useDelight = any (x: x.delight != null) packages;
  in {
    rawPackageList =
      singleton epkgs.use-package
      ++ optional useDiminish epkgs.diminish
      ++ optional useDelight epkgs.delight;

    init-el.preamble = mkMerge [''
      (eval-when-compile
        (require 'use-package))
      ''
      (mkIf useDiminish "(require 'diminish)")
      (mkIf useDelight "(require 'delight)")
    ];
  };
}
