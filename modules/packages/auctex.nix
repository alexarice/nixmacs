{ config, lib, epkgs,  ... }:

with lib;

{
  options.latex-hooks = mkOption {
    type = with types; listOf str;
    readOnly = true;
    visible = false;
  };

  config = {
    latex-hooks = [
      "(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)"
      "(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)"
      "(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)"
      "(add-hook 'LaTeX-mode-hook 'flyspell-mode)"
    ];

    use-package.tex = {
      tex = {
        defer = mkDefault true;
        package = mkDefault epkgs.elpaPackages.auctex;
        custom = {
          TeX-auto-save = mkDefault "t";
          TeX-parse-self = mkDefault "t";
          TeX-syntactic-comment = mkDefault "t";
          TeX-source-cerrelate-start-server = mkDefault "t";
          LaTeX-fill-break-at-separators = mkDefault "nil";
        };
      };
    };
  };
}
