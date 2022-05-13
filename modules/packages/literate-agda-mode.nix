{ config, lib, ... }:

with lib;

{
  package.literate-agda-mode = {
    use-package.mode = mkDefault ''"\\.lagda.tex\\'"'';
    priority = 1200;
  };
}
