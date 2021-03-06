{ config, lib, epkgs, ... }:

with lib;

{
  package.nix-shell = {
    package = mkDefault epkgs.nix-mode;
    use-package.commands = mkDefault [
      "nix-shell-unpack"
      "nix-shell-configure"
      "nix-shell-build"
    ];
  };
}
