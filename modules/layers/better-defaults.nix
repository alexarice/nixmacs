{ config, lib, ... }:

with lib;

let
  cfg = config.layers.better-defaults;
in
{
  options.layers.better-defaults.enable = mkEnableOption "better defaults";

  config = {
    settings.global-variables = {
      delete-old-versions = mkDefault (-1);
      version-control = mkDefault true;
      vc-make-backup-files = mkDefault true;
      backup-directory-alist = mkDefault "'((\".\" . \"~/.emacs.d/backups\"))";
      vc-follow-symlinks = mkDefault true;
      auto-save-file-name-transforms = mkDefault "'((\".*\" \"~/.emacs.d/auto-save-list/\" t))";
      inhibit-startup-screen = mkDefault true;
      ring-bell-function = mkDefault "'ignore";
      coding-system-for-read = mkDefault "'utf-8";
      coding-system-for-write = mkDefault "'utf-8";
      sentence-end-double-space = mkDefault false;
      default-fill-column = mkDefault 80;
      initial-scratch-message = mkDefault "nil";
      gc-cons-threshold = mkDefault 100000000;
      read-process-output-max = mkDefault (1024 * 1024);
    };

    init-el.preamble = mkAfter ''
      (tool-bar-mode -1)
      (menu-bar-mode -1)
    '';
  };
}
