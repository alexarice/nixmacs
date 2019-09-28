{ lib, pkgs, ... }:

with lib;

{
  package.haskell-mode = {
    external-packages = with pkgs.haskellPackages; mkDefault [ stylish-haskell ];
    use-package = {
      defer = true;
    };
  };
}
