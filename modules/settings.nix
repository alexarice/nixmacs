{ config, lib, ... }:

with lib;

let
  cfg = config.settings;
in{
  options.settings = {
    adaptive-wrap = {
      enable = mkEnableOption "global adaptive-wrap";
      indent = mkOption {
        type = types.int;
        default = 2;
        description = ''
          Adaptive wrap indent variable
        '';
      };
    };

    smooth-scrolling.enable = mkEnableOption "smooth scrolling";

    line-numbers.enable = mkEnableOption "line numbers";

    debug.enable = mkEnableOption "debug mode";

    delete-trailing-whitespace = mkEnableOption "whitespace";

    crux-C-a = mkEnableOption "Use Crux C-a";

    global-hl-line = mkEnableOption "Highlight line mode";

    recent-files-mode = mkEnableOption "Enable recentf-mode";

    electric-pair-mode = mkEnableOption "Enable electric-pair-mode";
  };

  config = {
    package = {
      adaptive-wrap = {
        inherit (cfg.adaptive-wrap) enable;
        use-package = {
          config = ''
            (setq-default adaptive-wrap-extra-indent ${builtins.toString cfg.adaptive-wrap.indent})
            (add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode)
            (global-visual-line-mode 1)
          '';
          diminish = "visual-line-mode";
        };
      };

      smooth-scrolling = {
        inherit (cfg.smooth-scrolling) enable;
        use-package = {
          config = "(smooth-scrolling-mode 1)";
          custom = {
            mouse-wheel-scroll-amount = "'(1 ((shift) . 1))";
            mouse-wheel-progressive-speed = false;
            mouse-wheel-follow-mouse = true;
            scroll-step = 1;
          };
        };
      };
    };

    init-el.postSetup = mkMerge [
      (mkIf cfg.line-numbers.enable ''
        (when (version<= "26.0.50" emacs-version )
          (global-display-line-numbers-mode))
        '')
      (mkIf cfg.debug.enable ''
        (setq debug-on-error t)
        (defun show-config ()
          "Show init.el"
          (interactive)
          (find-file (getenv "INITEL")))
        '')];

    init-el.preamble = mkMerge [
      (mkIf cfg.delete-trailing-whitespace ''
        (add-hook 'before-save-hook 'delete-trailing-whitespace)
      '')
      (mkIf cfg.electric-pair-mode ''
        (add-hook 'prog-mode-hook 'electric-pair-mode)
      '')
      (mkIf cfg.global-hl-line ''
        (global-hl-line-mode 1)
      '')
      (mkIf cfg.recent-files-mode ''
        (defun save-recentf-no-output ()
          "recentf-save-list without output"
          (interactive)
          (let ((inhibit-message t))
            (recentf-save-list)))
        (recentf-mode 1)
        (run-at-time nil (* 2 60) 'save-recentf-no-output)
      '')
    ];

    package.ivy.use-package.custom.ivy-use-virtual-buffers = mkIf cfg.recent-files-mode true;

    package.crux.use-package.bind."C-a" = mkIf cfg.crux-C-a "crux-move-beginning-of-line";
  };
}
