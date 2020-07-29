{ ... }:

let
  addFile = file: f: { config, lib, epkgs, pkgs, ... }@args:
    f args // { _file = file; };
in
{
  baseModules = [
    ./base.nix
    ./bootstrap.nix
    ./custom.nix
    ./font.nix
    ./init-el.nix
    ./keybindings/hydra.nix
    ./keybindings/major-modes.nix
    ./layers/agda.nix
    ./layers/better-defaults.nix
    ./layers/c.nix
    ./layers/completion.nix
    ./layers/fish.nix
    ./layers/git.nix
    ./layers/haskell.nix
    ./layers/ivy.nix
    ./layers/javascript.nix
    ./layers/latex.nix
    ./layers/lsp.nix
    ./layers/markdown.nix
    ./layers/mu4e.nix
    ./layers/nix.nix
    ./layers/nixmacs.nix
    ./layers/notmuch.nix
    ./layers/ocaml.nix
    ./layers/org.nix
    ./layers/python.nix
    ./layers/rust.nix
    ./layers/systemd.nix
    ./layers/yaml.nix
    ./package.nix
    ./settings.nix
    ./theme.nix
  ];

  packageModules = map (x: addFile (toString x) (import x)) [
    ./packages/adaptive-wrap.nix
    ./packages/agda-input.nix
    ./packages/agda2-mode.nix
    ./packages/anaconda-eldoc-mode.nix
    ./packages/anaconda-mode.nix
    ./packages/auctex-latexmk.nix
    ./packages/auctex.nix
    ./packages/cargo.nix
    ./packages/company-anaconda.nix
    ./packages/company-irony.nix
    ./packages/company-lsp.nix
    ./packages/company-nixos-options.nix
    ./packages/company-tern.nix
    ./packages/company.nix
    ./packages/counsel.nix
    ./packages/dante.nix
    ./packages/delight.nix
    ./packages/diminish.nix
    ./packages/direnv.nix
    ./packages/doom-modeline.nix
    ./packages/fish-mode.nix
    ./packages/flycheck-irony.nix
    ./packages/flycheck-rust.nix
    ./packages/flycheck.nix
    ./packages/general.nix
    ./packages/git-gutter.nix
    ./packages/haskell-mode.nix
    ./packages/hlint-refactor.nix
    ./packages/htmlize.nix
    ./packages/irony-eldoc.nix
    ./packages/irony.nix
    ./packages/ivy.nix
    ./packages/js2-mode.nix
    ./packages/js2-refactor.nix
    ./packages/lsp-haskell.nix
    ./packages/lsp-mode.nix
    ./packages/lsp-ui.nix
    ./packages/markdown-agda-mode.nix
    ./packages/markdown-mode.nix
    ./packages/merlin.nix
    ./packages/mu4e-overview.nix
    ./packages/mu4e.nix
    ./packages/neotree.nix
    ./packages/nix-drv-mode.nix
    ./packages/nix-mode.nix
    ./packages/nix-repl.nix
    ./packages/nix-shell.nix
    ./packages/nixos-options.nix
    ./packages/org-agda-mode.nix
    ./packages/org-bullets.nix
    ./packages/org.nix
    ./packages/ox-publish.nix
    ./packages/powerline.nix
    ./packages/projectile.nix
    ./packages/racer.nix
    ./packages/rainbow-delimiters.nix
    ./packages/rainbow-mode.nix
    ./packages/rjsx-mode.nix
    ./packages/rust-mode.nix
    ./packages/smartparens.nix
    ./packages/smooth-scrolling.nix
    ./packages/swiper.nix
    ./packages/systemd.nix
    ./packages/toml-mode.nix
    ./packages/tuareg.nix
    ./packages/unicode-fonts.nix
    ./packages/use-package-chords.nix
    ./packages/which-key.nix
    ./packages/xah-fly-keys.nix
    ./packages/yaml-mode.nix
    ./packages/yasnippet.nix
  ];
}
