{ pkgs }:
self: super: {
  lsp-latex = pkgs.callPackage ./lsp-latex.nix { };
}
