{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.latex;
in
{
  options.layers.latex = {
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
    packages = {
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
    layers.auto-complete.company-hooks."LaTeX-mode" = [ "company-auctex" ];
    layers.smartparens.hooks = "LaTeX-mode";
  };
}
