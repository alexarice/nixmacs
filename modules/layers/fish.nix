{ config, lib, ... }:

with lib;

let
  cfg = config.layers.fish;
in
{
  options.layers.fish = {
    enable = mkEnableOption "fish layer";
  };

  config = mkIf cfg.enable {
    package = {
      fish-mode.enable = true;
    };
  };
}
