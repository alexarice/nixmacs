{ config, lib, ... }:

with lib;

{
  config.package.nix-mode = {
    mode = mkDefault "\"\\\\.nix\\\\'\"";
    custom.nix-indent-function = mkDefault "'nix-indent-line";
  };
}
