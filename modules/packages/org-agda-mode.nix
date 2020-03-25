{ lib, ... }:

with lib;

{
  package.org-agda-mode.use-package.mode = mkDefault ''"\\.lagda.org\\'"'';
}
