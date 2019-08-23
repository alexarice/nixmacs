{ config, lib, ... }:

with lib;

{
  config.use-package.projectile = {
    defer = mkDefault true;
    commands = mkDefault [
      "projectile-ack"
      "projectile-ag"
      "projectile-compile-project"
      "projectile-dired"
      "projectile-find-dir"
      "projectile-find-file"
      "projectile-find-tag"
      "projectile-test-project"
      "projectile-grep"
      "projectile-invalidate-cache"
      "projectile-kill-buffers"
      "projectile-multi-occur"
      "projectile-project-p"
      "projectile-project-root"
      "projectile-recentf"
      "projectile-regenerate-tags"
      "projectile-replace"
      "projectile-replace-regexp"
      "projectile-run-async-shell-command-in-root"
      "projectile-run-shell-command-in-root"
      "projectile-switch-project"
      "projectile-switch-to-buffer"
      "projectile-vc"
    ];
    config = mkDefault (singleton ''
      (projectile-global-mode)
    '');
    diminish = mkDefault "projectile-mode";
  };
}
