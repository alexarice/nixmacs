{ config, lib, ... }:

with lib;

{
  package.yaml-mode.use-package.hook = mkDefault ''"\\.ya?ml\\'"'';
}
