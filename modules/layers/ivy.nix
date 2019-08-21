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
    use-package = {
      ivy = {
        enable = true;
        package = epkgs.melpaPackages.ivy;
        config = singleton ''
          (ivy-mode 1)
        '';
        diminish = "ivy-mode";
        custom = [ "(ivy-initial-inputs-alist nil)" ];
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
        enable = config.use-package.projectile.enable;
        package = epkgs.melpaPackages.counsel-projectile;
      };
      projectile = {
        custom = [ "(projectile-completion-system 'ivy)" ];
      };
      smex = {
        enable = true;
        package = epkgs.melpaPackages.smex;
      };
    };
  };
}
