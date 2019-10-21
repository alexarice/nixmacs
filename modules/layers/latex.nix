{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.latex;
in
{
  options.layers.latex = {
    enable = mkEnableOption "LaTeX layer";

    enable-folding = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable fold mode for latex mode.
      '';
    };
  };

  config = mkIf cfg.enable {
    package = {
      tex = {
        enable = mkDefault true;
        use-package = {
          init = mkMerge (
            singleton (mkDefault config.latex-hooks)
            ++ optional cfg.enable-folding (mkDefault "(add-hook 'LaTeX-mode-hook 'TeX-fold-mode)")
            ++ optional config.package.smartparens.enable (mkDefault "(add-hook 'LaTeX-mode-hook '${config.package.smartparens.settings.sp-mode})")
          );
          config = mkDefault "(auctex-latexmk-setup)";
        };
      };
      company.settings.company-hooks.LaTeX-mode = mkDefault [
        "company-files"
        "company-auctex"
        "(company-ispell company-dabbrev)"
      ];
      auctex-latexmk.enable = mkDefault true;
    };

    keybindings.major-mode.TeX-latex-mode = {
      b = "TeX-command-master";
    };
  };
}
