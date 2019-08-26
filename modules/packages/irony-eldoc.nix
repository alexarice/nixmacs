{ config, lib, epkgs, ... }:

with lib;

{
  config.use-package.irony-eldoc = {
    hook = mkDefault "irony-mode";
  };
}
