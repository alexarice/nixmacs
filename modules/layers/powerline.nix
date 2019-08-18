{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.powerline;
in
{
  options.layers.powerline.enable = mkEnableOption "Powerline";

  config = mkIf cfg.enable {
    packages = {
      powerline = {
        enable = true;
        package = epkgs.melpaPackages.powerline;
        custom = [ "(powerline-default-separator 'utf-8)" ];
      };
    };
  };
}
