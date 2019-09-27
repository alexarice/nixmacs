{ config, lib, ... }:

with lib;

let
  cfg = config.layers.mu4e;
in
{
  options.layers.mu4e = {
    enable = mkEnableOption "mu4e email client";
  };

  config = mkIf cfg.enable {
    package = {
      mu4e-overview.enable = true;
      mu4e.enable = true;
    };
  };
}
