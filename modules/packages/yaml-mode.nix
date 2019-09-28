{ config, lib, ... }:

with lib;

{
  package.yaml-mode.use-package.mode = mkDefault ''"\\.ya?ml\\'"'';
}
