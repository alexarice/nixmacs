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
        config = ''
          (ivy-mode 1)
        '';
        diminish = "ivy-mode";
      };
      counsel = {
        enable = true;
        package = epkgs.melpaPackages.counsel;
        config = ''
          (counsel-mode 1)
        '';
        diminish = "counsel-mode";
      };
      swiper = {
        enable = true;
        package = epkgs.melpaPackages.swiper;
        bind."C-s" = "swiper";
      };
    };
  };
}
