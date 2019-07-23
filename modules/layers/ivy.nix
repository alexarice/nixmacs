{ config, pkgs, lib, ... }:

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
        package = pkgs.emacsPackagesNg.melpaPackages.ivy;
        config = ''
          (ivy-mode 1)
        '';
        diminish = "ivy-mode";
      };
      counsel = {
        enable = true;
        package = pkgs.emacsPackagesNg.melpaPackages.counsel;
        config = ''
          (counsel-mode 1)
        '';
        diminish = "counsel-mode";
      };
      swiper = {
        enable = true;
        package = pkgs.emacsPackagesNg.melpaPackages.swiper;
        bind."C-s" = "swiper";
      };
    };
  };
}
