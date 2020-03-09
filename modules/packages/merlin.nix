{ lib, pkgs, ... }:

with lib;

{
  package.merlin = {
    external-packages = mkDefault [ pkgs.ocamlPackages.merlin ];

    use-package = {
      hook = mkDefault "((tuareg-mode caml-mode) . merlin-mode)";
      custom.merlin-command = "\"${pkgs.ocamlPackages.merlin}/bin/ocamlmerlin\"";
    };
  };
}
