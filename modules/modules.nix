{ ... }:

rec {
  baseModules = map (x: import x) [
    ./base.nix
    ./bootstrap.nix
    ./font.nix
    ./init-el.nix
    ./layers/c.nix
    ./layers/completion.nix
    ./layers/git.nix
    ./layers/ivy.nix
    ./layers/latex.nix
    ./layers/nix.nix
    ./layers/nixmacs.nix
    ./layers/org.nix
    ./layers/python.nix
    ./package.nix
    ./settings.nix
    ./theme.nix
  ];

  packageModules = map (x: import x) [
    ./packages/anaconda-eldoc-mode.nix
    ./packages/anaconda-mode.nix
    ./packages/auctex-latexmk.nix
    ./packages/auctex.nix
    ./packages/company-anaconda.nix
    ./packages/company-irony.nix
    ./packages/company-nixos-options.nix
    ./packages/company.nix
    ./packages/counsel.nix
    ./packages/direnv.nix
    ./packages/flycheck-irony.nix
    ./packages/flycheck.nix
    ./packages/git-gutter.nix
    ./packages/irony-eldoc.nix
    ./packages/irony.nix
    ./packages/ivy.nix
    ./packages/neotree.nix
    ./packages/nix-drv-mode.nix
    ./packages/nix-mode.nix
    ./packages/nix-repl.nix
    ./packages/nix-shell.nix
    ./packages/nixos-options.nix
    ./packages/org-bullets.nix
    ./packages/powerline.nix
    ./packages/projectile.nix
    ./packages/rainbow-delimiters.nix
    ./packages/rainbow-mode.nix
    ./packages/smartparens.nix
    ./packages/swiper.nix
    ./packages/yasnippet.nix
  ];

  modules = baseModules ++ packageModules;
}
