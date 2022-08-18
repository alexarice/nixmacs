
{ config, lib, ... }:

with lib;

let
  cfg = config.settings;
in
{
  options.settings = {
    global-variables = mkOption {
      type = types.varBindType;
      default = {};
      description = ''
        Variables to be set in <filename>init.el</filename>.
      '';
    };

    smooth-scrolling.enable = mkEnableOption "smooth scrolling";

    line-numbers.enable = mkEnableOption "line numbers";

    debug.enable = mkEnableOption "debug mode";

    config-command.enable = mkEnableOption "show-config command";

    delete-trailing-whitespace = mkEnableOption "deleting trailing whitespace";

    crux-C-a = mkEnableOption "C-a from Crux";

    global-hl-line = mkEnableOption "highlight line mode";

    recent-files-mode = mkEnableOption "recentf-mode";

    electric-pair-mode = mkEnableOption "electric-pair-mode";

    cancel-minibuffer-with-mouse = mkEnableOption "cancel minibuffer on mouse click";

    minibuffer-inherit-input-mode = mkEnableOption "let minibuffer inherit parent buffer's input mode";
  };

  config = {
    init-el.postSetup = mkMerge [
      (
        mkIf cfg.line-numbers.enable ''
          (when (version<= "26.0.50" emacs-version )
            (add-hook 'prog-mode-hook 'display-line-numbers-mode)
            (add-hook 'text-mode-hook 'display-line-numbers-mode))
        ''
      )
      (
        mkIf cfg.debug.enable ''
          (setq debug-on-error t)
        ''
      )
      (
        mkIf cfg.config-command.enable ''
          (defun show-config ()
            "Show init.el"
            (interactive)
            (find-file (getenv "INITEL")))
        ''
      )
      (
        mkIf cfg.cancel-minibuffer-with-mouse ''
          (defun stop-using-minibuffer ()
            "kill the minibuffer"
            (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
            (abort-recursive-edit)))

          (add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)
        ''
      )
      (
        mkIf cfg.minibuffer-inherit-input-mode ''
          (defun my-inherit-input-method ()
            "Inherit input method from `minibuffer-selected-window'."
            (let* ((win (minibuffer-selected-window))
                  (buf (and win (window-buffer win))))
               (when buf
                 (activate-input-method (buffer-local-value 'current-input-method buf)))))

          (add-hook 'minibuffer-setup-hook #'my-inherit-input-method)
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

    settings.global-variables.recentf-max-saved-items = mkIf cfg.recent-files-mode (mkDefault 100);

    package.ivy.use-package.custom.ivy-use-virtual-buffers = mkIf cfg.recent-files-mode true;

    package.crux.use-package.bind."C-a" = mkIf cfg.crux-C-a "crux-move-beginning-of-line";
  };
}
