{ config, lib, ... }:

with lib;

let
  cfg = config.settings;
  inherit (import ../types/customType.nix { inherit lib; }) customType printVariables;
in
{
  options.settings = {
    global-variables = mkOption {
      type = customType;
      default = {};
      description = ''
        Variables to be set in <filename>init.el</filename>.
      '';
    };

    smooth-scrolling.enable = mkEnableOption "smooth scrolling";

    line-numbers.enable = mkEnableOption "line numbers";

    debug.enable = mkEnableOption "debug mode";

    delete-trailing-whitespace = mkEnableOption "deleting trailing whitespace";

    crux-C-a = mkEnableOption "C-a from Crux";

    global-hl-line = mkEnableOption "highlight line mode";

    recent-files-mode = mkEnableOption "recentf-mode";

    electric-pair-mode = mkEnableOption "electric-pair-mode";
  };

  config = {
    init-el.postSetup = mkMerge [
      (
        mkIf cfg.line-numbers.enable ''
          (when (version<= "26.0.50" emacs-version )
            (global-display-line-numbers-mode))
        ''
      )
      (
        mkIf cfg.debug.enable ''
          (setq debug-on-error t)
          (defun show-config ()
            "Show init.el"
            (interactive)
            (find-file (getenv "INITEL")))
        ''
      )
    ];

    init-el.preamble = mkMerge [
      (
        mkIf cfg.delete-trailing-whitespace ''
          (add-hook 'before-save-hook 'delete-trailing-whitespace)
        ''
      )
      (
        mkIf cfg.electric-pair-mode ''
          (add-hook 'prog-mode-hook 'electric-pair-mode)
        ''
      )
      (
        mkIf cfg.global-hl-line ''
          (global-hl-line-mode 1)
        ''
      )
      (
        mkIf cfg.recent-files-mode ''
          (defun save-recentf-no-output ()
            "recentf-save-list without output"
            (interactive)
            (let ((inhibit-message t))
              (recentf-save-list)))
          (recentf-mode 1)
          (run-at-time nil (* 2 60) 'save-recentf-no-output)
        ''
      )
      (
        mkAfter ''
          ${printVariables cfg.global-variables}
        ''
      )
    ];

    package.ivy.use-package.custom.ivy-use-virtual-buffers = mkIf cfg.recent-files-mode true;

    package.crux.use-package.bind."C-a" = mkIf cfg.crux-C-a "crux-move-beginning-of-line";
  };
}
