{ pkgs, lib }:

let
  bindTypeModule = import ./bindType.nix { };
in
[
  ./base.nix
  ./packages.nix
]
