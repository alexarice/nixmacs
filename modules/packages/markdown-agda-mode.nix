{ config, lib, ... }:

with lib;

{
  package.markdown-agda-mode = {
    use-package.mode = mkDefault ''"\\.lagda.md\\'"'';
    priority = 1200;
  };
}
