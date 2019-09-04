{ config, lib, ... }:

with lib;

{
  package.org-bullets.use-package.hook = mkDefault "(org-mode . org-bullets-mode)";
}
