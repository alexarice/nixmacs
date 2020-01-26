{ lib, ... }:

with lib;

{
  package.company-lsp.use-package = {
    commands = mkDefault [ "company-lsp" ];
  };
}
