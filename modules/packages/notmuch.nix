{ lib, ... }:

with lib;

{
  package.notmuch.use-package.init = mkDefault ''
    (autoload 'notmuch "notmuch" "notmuch mail" t)
  '';
};
