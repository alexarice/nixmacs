{ config, lib, ... }:

with lib;

{
  package.markdown-mode.use-package = {
    defer = true;
    mode = mkDefault ''
      (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
    '';
    custom.markdown-command = "multimarkdown";
  };
}
