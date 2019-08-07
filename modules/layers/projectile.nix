{ config, lib, epkgs, ... }:

with lib;

let
  cfg = config.layers.projectile;
in
{
  options.layers.projectile = {
    enable = mkEnableOption "Projectile Layer";
  };

  config = mkIf cfg.enable {
    packages = {
      projectile = {
        enable = true;
        defer = true;
        commands = [
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
        config = singleton ''
          (projectile-global-mode)
        '';
        diminish = "projectile-mode";
        package = epkgs.melpaPackages.projectile;
      };
    };
  };
}
