{ config, lib, epkgs, ... }:

with lib;

{
  package.nix-repl = {
    package = mkDefault epkgs.nix-mode;
    use-package.commands = mkDefault [ "nix-repl" ];
  };
}
