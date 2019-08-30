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
    package = {
      tex = {
        enable = true;
        use-package = {
          init = mkMerge (singleton config.latex-hooks ++ optional cfg.enable-folding "(add-hook 'LaTeX-mode-hook 'TeX-fold-mode)");
          config = "(auctex-latexmk-setup)";
        };
      };

      auctex-latexmk.enable = true;
    };
    layers.completion.company-hooks."LaTeX-mode" = [ "company-auctex" ];
  };
}
