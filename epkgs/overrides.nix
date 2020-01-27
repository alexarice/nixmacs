{ pkgs }:
self: super: {
  lsp-latex = self.callPackage ./lsp-latex.nix { };
}
