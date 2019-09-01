{ config, lib, ... }:

with lib;

{
  config.package.js2-mode.use-package.mode = mkDefault ''"\\.js\\'"'';
}
