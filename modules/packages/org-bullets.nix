{ config, lib, ... }:

with lib;

{
  config.package.org-bullets.use-package.hook = mkDefault "(org-mode . org-bullets-mode)";
}
