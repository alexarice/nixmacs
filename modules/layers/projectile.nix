{ config, lib, ... }:

with lib;

let
  cfg = config.layers.projectile;
in
{
  options.layers.projectile = {
    enable = mkEnableOption "Projectile Layer";
  };

  config = mkIf cfg.enable {

  };
}
