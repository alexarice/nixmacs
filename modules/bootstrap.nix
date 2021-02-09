{ config, epkgs, lib, ... }:

with lib;
{
  config = let
    packages = attrValues config.package;
    useDiminish = any (x: x.use-package.diminish != null) packages;
    useDelight = any (x: x.use-package.delight != null) packages;
    useChords = any (x: x.use-package.chords != {}) packages;
  in
    {
      rawPackageList = singleton epkgs.use-package;

      package = {
        use-package-chords.enable = mkIf useChords true;
        diminish.enable = mkIf useDiminish true;
        delight.enable = mkIf useDelight true;
      };

      init-el.preamble = mkBefore ''
        (setq user-init-file (or load-file-name (buffer-file-name)))

        (require 'use-package)
        (package-initialize)
        (require 'bind-key)
      '';
    };
}
