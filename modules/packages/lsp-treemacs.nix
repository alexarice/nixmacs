{ lib, ... }:

with lib;

{
  package.lsp-treemacs.use-package = {
    defer = true;
    custom.lsp-treemacs-sync-mode = mkDefault 1;
  };
}
