{ config, lib, pkgs, ... }:

with lib;

{
  package.lsp-pyright = {
    use-package = {
      custom = {
        lsp-pyright-usu-library-code-for-types = true;
      };
      hook = mkDefault ''
        (python-mode . (lambda () (require 'lsp-pyright) (lsp)))
      '';
    };
    external-packages = [ pkgs.pyright ];
  };
}
