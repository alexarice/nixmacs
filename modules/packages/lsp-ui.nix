{ lib, ... }:

with lib;

{
  package.lsp-ui.use-package = {
    commands = [ "lsp-ui-mode" ];
  };
}
