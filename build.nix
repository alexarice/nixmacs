let
  pkgs = import <nixpkgs> {};
in
import ./. {
  inherit pkgs;
  configurationFile = ./example/minimal.nix;
}
