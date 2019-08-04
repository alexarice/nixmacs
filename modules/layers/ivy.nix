{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.ivy;
in
{
  options.layers = {
    ivy = {
      enable = mkEnableOption "Ivy layer";
    };
  };

  config = mkIf cfg.enable {
    packages = {
      ivy = {
        enable = true;
        package = epkgs.melpaPackages.ivy;
        config = singleton ''
          (ivy-mode 1)
        '';
        diminish = "ivy-mode";
      };
      counsel = {
        enable = true;
        package = epkgs.melpaPackages.counsel;
        config = singleton ''
          (counsel-mode 1)
        '';
        diminish = "counsel-mode";
      };
      swiper = {
        enable = true;
        package = epkgs.melpaPackages.swiper;
        bind."C-s" = "swiper";
      };
      counsel-projectile = {
        enable = config.packages.projectile.enable;
        package = epkgs.melpaPackages.counsel-projectile;
      };
      projectile = {
        init = singleton ''
          (setq projectile-switch-project-action 'counsel-projectile-find-file)
        '';
      };
    };
  };
}
