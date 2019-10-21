{ config, lib, ... }:

with lib;

let
  cfg = config.package.smartparens.settings;
in
{
  options.package.smartparens.settings = {
    strict = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to use smartparens-strict-mode.
      '';
    };

    smartparens-modes = mkOption {
      type = with types; listOf str;
      description = ''
        Modes to start smartparens on
      '';
    };
  };

  config.package.smartparens = let
    sp-mode = "smartparens-${if cfg.strict then "strict-" else ""}mode";
    start-modes = "(${concatStringsSep " " cfg.smartparens-modes})";
  in {
    settings.smartparens-modes = [ "prog-mode" ];
    use-package = {
      defer = mkDefault true;
      commands = mkDefault [ "sp-split-sexp" "sp-newline" "sp-up-sexp" ];
      custom = {
        sp-show-pair-delay = mkDefault "0.1";
        sp-show-pair-from-inside = mkDefault true;
        sp-cancel-autoskip-on-backward-movement = mkDefault false;
        sp-highlight-pair-overlay = mkDefault false;
        sp-highlight-wrap-overlay = mkDefault false;
        sp-highlight-wrap-tag-overlay = mkDefault false;
      };
      config = mkDefault ''
        (require 'smartparens-config)
        (defun newline-indent (&rest _ignored)
          "Insert an extra newline after point, and reindent."
          (newline)
          (indent-according-to-mode)
          (forward-line -1)
          (indent-according-to-mode))
        (sp-local-pair 'prog-mode "{" nil :post-handlers '((newline-indent "RET")))
        (sp-local-pair 'prog-mode "[" nil :post-handlers '((newline-indent "RET")))
      '';
      diminish = sp-mode;
      hook = "((${start-modes} . ${sp-mode}) (${start-modes} . show-smartparens-mode))";
    };
  };
}
