{ config, epkgs, lib, pkgs, ... }:

with lib;

let
  cfg = config.layers.latex;
  cfg-lsp = config.package.lsp-mode.enable;
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
        external-packages = mkIf cfg-lsp [ pkgs.texlab ];
        use-package = {
          init = mkMerge (
            singleton (mkDefault config.latex-hooks)
            ++ optional cfg.enable-folding (mkDefault "(add-hook 'LaTeX-mode-hook 'TeX-fold-mode)")
          );
          config = mkDefault "(auctex-latexmk-setup)";
        };
      };
      lsp-mode.settings.lsp-hooks = mkIf cfg-lsp [ "LaTeX-mode" ];
      company-lsp.enable = mkIf cfg-lsp true;
      lsp-latex.enable = mkIf cfg-lsp true;
      company.settings.company-hooks.LaTeX-mode = mkDefault [
        "company-files"
        "company-lsp"
        "company-auctex"
        "(company-ispell company-dabbrev)"
      ];
      auctex-latexmk.enable = mkDefault true;
      smartparens.settings.smartparens-modes = [ "LaTeX-mode" ];
    };

    keybindings.major-mode."latex-mode".binds = {
      b = "TeX-command-master";
    };
  };
}
