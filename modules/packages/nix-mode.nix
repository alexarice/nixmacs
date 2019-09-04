{ config, lib, ... }:

with lib;

{
  package.nix-mode.use-package = {
    mode = mkDefault ''"\\.nix\\'"'';
    custom.nix-indent-function = mkDefault "'nix-indent-line";
  };
}
