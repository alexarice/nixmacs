{ config, lib, epkgs, ... }:

with lib;

{
  package.irony-eldoc.use-package.hook = mkDefault "irony-mode";
}
