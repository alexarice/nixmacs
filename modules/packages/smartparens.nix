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
        Use smartparens-strict-mode
      '';
    };
  };

  config.package.smartparens.use-package = let
    sp-mode = "smartparens-${if cfg.strict then "strict-" else ""}mode";
  in {
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
    hook = "((prog-mode . ${sp-mode}) (prog-mode . show-smartparens-mode))";
  };
}
