{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.packages.latex;
in
{
  options.packages.latex = {
    enable = mkEnableOption "Latex layer";

    enable-folding = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable fold mode in latex mode
      '';
    };
  };

  config = mkIf cfg.enable {
    use-package = {
      tex = {
        defer = true;
        enable = true;
        package = epkgs.elpaPackages.auctex;
        custom = [
          "(TeX-auto-save t)"
          "(TeX-parse-self t)"
          "(TeX-syntactic-comment t)"
          "(TeX-source-cerrelate-start-server t)"
          "(LaTeX-fill-break-at-separators nil)"
        ];
        init = [
          "(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)"
          "(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)"
          "(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)"
          "(add-hook 'LaTeX-mode-hook 'flyspell-mode)"
        ] ++ optional cfg.enable-folding "(add-hook 'LaTeX-mode-hook 'TeX-fold-mode)";
        config = singleton "(auctex-latexmk-setup)";
      };

      auctex-latexmk = {
        defer = true;
        enable = true;
        package = epkgs.melpaPackages.auctex-latexmk;
        custom = "(auctex-latexmk-inherit-TeX-PDF-mode t)";
      };
    };
    packages.company.company-hooks."LaTeX-mode" = [ "company-auctex" ];
    packages.parens.hooks = "LaTeX-mode";
  };
}
