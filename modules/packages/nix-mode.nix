{ config, lib, ... }:

with lib;

{
  config.use-package.nix-mode = {
    mode = mkDefault "\"\\\\.nix\\\\'\"";
    custom.nix-indent-function = mkDefault "'nix-indent-line";
  };
}
