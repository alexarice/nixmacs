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
      ivy.enable = true;
      counsel.enable = true;
      swiper.enable = true;
      counsel-projectile.enable = config.package.projectile.enable;
      projectile.use-package.custom.projectile-completion-system = "'ivy";
      smex.enable = true;
    };
  };
}
