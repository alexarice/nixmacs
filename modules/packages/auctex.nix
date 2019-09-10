{ config, lib, epkgs, ... }:

with lib;

let
  cfg = config.package.tex.settings;
in
{
  options = {
    latex-hooks = mkOption {
      type = types.str;
      readOnly = true;
      visible = false;
    };
    package.tex.settings.TeX-view-program-selection = mkOption {
      type = with types; attrsOf str;
      default = {};
      example = {
        output-pdf = "zathura";
      };
      description = ''
        Builds the TeX-view-program-selection variable.
      '';
    };
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

      settings.TeX-view-program-selection = {
        "(output-dvi has-no-display-manager)" = mkDefault "dvi2tty";
        "(output-dvi style-pstricks)" = mkDefault "dvips and gv";
        output-dvi = mkDefault "xdvi";
        output-pdf = mkDefault "Evince";
        output-html = mkDefault "xgd-open";
      };

      use-package = {
        defer = mkDefault true;
        mode = ''("\\.tex\\'" . TeX-latex-mode)'';

        custom = {
          TeX-auto-save = mkDefault true;
          TeX-parse-self = mkDefault true;
          TeX-syntactic-comment = mkDefault true;
          TeX-source-cerrelate-start-server = mkDefault true;
          TeX-view-program-selection = mkDefault ''
            '(${concatStringsSep "\n" (mapAttrsToList (n: v: "(${n} \"${v}\")") cfg.TeX-view-program-selection)})
          '';
          LaTeX-fill-break-at-separators = mkDefault false;
        };
      };
    };
  };
}
