{ config, lib, epkgs, ... }:

with lib;

{
  config.package.nix-drv-mode = {
    package = with epkgs; mkDefault [ nix-mode json-mode ];
    use-package.mode = mkDefault "\"\\\\.drv\\\\'\"";
  };
}
