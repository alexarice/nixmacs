{ config, lib, ... }:

with lib;

let
  cfg = config.layers.ivy;
in
{
  options.layers = {
    ivy = {
      enable = mkEnableOption "ivy layer";
    };
  };

  config = mkIf cfg.enable {
    package = {
      ivy.enable = mkDefault true;
      counsel.enable = mkDefault true;
      swiper.enable = mkDefault true;
      counsel-projectile.enable = mkDefault config.package.projectile.enable;
      projectile.use-package.custom.projectile-completion-system = mkDefault "'ivy";
      smex.enable = mkDefault true;
    };
  };
}
