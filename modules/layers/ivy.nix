{ config, lib, ... }:

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
      ivy.enable = true;
      counsel.enable = true;
      swiper.enable = true;
      counsel-projectile.enable = config.use-package.projectile.enable;
      projectile.custom.projectile-completion-system = "'ivy";
      smex.enable = true;
    };
  };
}
