{ lib, pkgs, ... }:

with lib;

{
  package.racer = {
    external-packages = mkDefault [ pkgs.rustracer ];
    use-package = {
      hook = mkDefault "(rust-mode . racer-mode)";
    };
  };
}
