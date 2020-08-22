{ config, lib, ... }:

with lib;

let
  cfg = config.package.flycheck.settings;
in
{
  options.package = add-settings "flycheck" {
    disabled-checkers = mkOption {
      type = with types; listOf str;
      default = [];
      description = ''
        Checkers to be added to flycheck-disabled-checkers.
      '';
    };
  };

  config.package.flycheck.use-package = {
    init = ''
      (progn
        (define-fringe-bitmap 'my-flycheck-fringe-indicator
        (vector #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00011100
                #b00111110
                #b00111110
                #b00111110
                #b00011100
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000))

        (flycheck-define-error-level 'error
          :severity 2
          :overlay-category 'flycheck-error-overlay
          :fringe-bitmap 'my-flycheck-fringe-indicator
          :fringe-face 'flycheck-fringe-error)

        (flycheck-define-error-level 'warning
          :severity 1
          :overlay-category 'flycheck-warning-overlay
          :fringe-bitmap 'my-flycheck-fringe-indicator
          :fringe-face 'flycheck-fringe-warning)

        (flycheck-define-error-level 'info
          :severity 0
          :overlay-category 'flycheck-info-overlay
          :fringe-bitmap 'my-flycheck-fringe-indicator
          :fringe-face 'flycheck-fringe-info))
    '';
    config = mkDefault "(global-flycheck-mode)";
    custom.flycheck-disabled-checkers = "'(${concatStringsSep " " cfg.disabled-checkers})";
  };
}
