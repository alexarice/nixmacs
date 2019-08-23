{ config, lib, ... }:

with lib;

let
  cfg = config.packages.powerline;
in
{
  options.packages.powerline.enable = mkEnableOption "Powerline";

  config = mkIf cfg.enable {
    use-package = {
      powerline = {
        enable = true;
        custom = [ "(powerline-default-separator 'utf-8)" ];
      };
    };
  };
}
