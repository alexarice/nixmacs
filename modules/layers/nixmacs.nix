{ config, lib, ... }:

with lib;

let
  cfg = config.layers.nixmacs;
in
{
  options.layers.nixmacs = {
    enable = (mkEnableOption "Nixmacs base layer") // { default = true; };
  };

  config = mkIf cfg.enable {
    init-el.preamble = ''
      (setq delete-old-versions -1 )		; delete excess backup versions silently
      (setq version-control t )		; use version control
      (setq vc-make-backup-files t )		; make backups file even when in version controlled dir
      (setq backup-directory-alist '(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
      (setq vc-follow-symlinks t )				       ; don't ask for confirmation when opening symlinked file
      (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
      (setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
      (setq ring-bell-function 'ignore )	; silent bell when you make a mistake
      (setq coding-system-for-read 'utf-8 )	; use utf-8 by default
      (setq coding-system-for-write 'utf-8 )
      (setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
      (setq default-fill-column 80)		; toggle wrapping text at the 80th character
      (setq initial-scratch-message "Welcome to Emacs") ; print a default message in the empty scratch buffer opened at startup

      (tool-bar-mode -1) ; disable toolbar
      (menu-bar-mode -1) ; disable menu
    '';

    use-package = {
      crux.enable = mkDefault true;
      flycheck = mkDefault true;
      neotree.enable = mkDefault true;
      powerline.enable = mkDefault true;
      projectile.enable = mkDefault true;
      rainbow-delimiters = mkDefault true;
      rainbow-mode.enable = mkDefault true;
      smartparens.enable = mkDefault true;
      undo-tree.enable = mkDefault true;
    };

    layers.ivy.enable = mkDefault true;
  };
}