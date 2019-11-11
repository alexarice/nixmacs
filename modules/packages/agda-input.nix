{ lib, epkgs, ... }:

with lib;

{
  package.agda-input = {
    package = epkgs.agda2-mode;
  };
}
