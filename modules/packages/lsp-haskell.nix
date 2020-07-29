{ lib, pkgs, ... }:

with lib;

{
  package.lsp-haskell = {
    use-package.custom.lsp-haskell-process-path-hie = ''
      "haskell-language-server-wrapper"
    '';
    external-packages = [ pkgs.haskellPackages.haskell-language-server ];
  };
}
