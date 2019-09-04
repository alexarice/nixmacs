{ config, lib, ... }:

with lib;

{
  package.js2-mode.use-package.mode = mkDefault ''"\\.js\\'"'';
}
