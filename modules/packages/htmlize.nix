{ lib, ... }:

with lib;

{
  package.htmlize.use-package.commands = mkDefault [
    "htmlize-all"
    "htmlize-buffer"
    "htmlize-region"
    "htmlize-many-files"
    "htmlize-many-files-dired"
  ];
}
