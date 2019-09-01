{ config, lib, epkgs, ... }:

with lib;

{
  options.latex-hooks = mkOption {
    type = types.str;
    readOnly = true;
    visible = false;
  };

  config = {
    latex-hooks = ''
      (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
      (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
      (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
      (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    '';

    package.tex = {
      package = mkDefault epkgs.elpaPackages.auctex;

      use-package = {
        defer = mkDefault true;
        mode = ''("\\.tex\\'" . TeX-latex-mode)'';

        custom = {
          TeX-auto-save = mkDefault true;
          TeX-parse-self = mkDefault true;
          TeX-syntactic-comment = mkDefault true;
          TeX-source-cerrelate-start-server = mkDefault true;
          LaTeX-fill-break-at-separators = mkDefault false;
        };
      };
    };
  };
}
