{ pkgs }:
self: super: {
  lsp-latex = self.callPackage ./lsp-latex.nix { };
  org-agda-mode = self.callPackage ./org-agda-mode.nix { };
  markdown-agda-mode = self.callPackage ./markdown-agda-mode.nix { };
}
