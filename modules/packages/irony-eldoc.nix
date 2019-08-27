{ config, lib, epkgs, ... }:

with lib;

{
  config.package.irony-eldoc = {
    hook = mkDefault "irony-mode";
  };
}
