{ config, lib, ... }:

with lib;

let
  cfg = config.layers.powerline;
in
{
  options.layers.powerline.enable = mkEnableOption "Powerline";

  config = mkIf cfg.enable {
    use-package = {
      powerline = {
        enable = true;
        custom.powerline-default-separator = "'utf-8";
      };
    };
  };
}
