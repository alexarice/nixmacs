{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.settings;
in
{
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
  };

  config = {
    packages = {
      adaptive-wrap = {
        inherit (cfg.adaptive-wrap) enable;
        package = epkgs.elpaPackages.adaptive-wrap;
        config = ''
          (setq-default adaptive-wrap-extra-indent ${builtins.toString cfg.adaptive-wrap.indent})
          (add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode)
          (global-visual-line-mode 1)
        '';
        diminish = "visual-line-mode";
      };

      smooth-scrolling = {
        inherit (cfg.smooth-scrolling) enable;
        package = epkgs.melpaPackages.smooth-scrolling;
        config = ''
          (smooth-scrolling-mode 1)
          (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
          (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
          (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
          (setq scroll-step 1) ;; keyboard scroll one line at a time
        '';
      };
    };

    init-el.postSetup = mkIf cfg.line-numbers.enable ''
      (when (version<= "26.0.50" emacs-version )
        (global-display-line-numbers-mode))
    '';

  };
}
