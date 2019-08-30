{ config, lib, epkgs, ... }:

with lib;

{
  config.package.irony-eldoc.use-package.hook = mkDefault "irony-mode";
}
