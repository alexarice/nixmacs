let
  pkgs = import <nixpkgs> {};
in
import ./. {
  inherit pkgs;
  lib = pkgs.lib;
  configurationFile = ./example/minimal.nix;
}
