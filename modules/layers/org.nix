{ config, lib, ... }:

with lib;

let
  cfg = config.layers.org.enable;
in
{
  options.layers.org.enable = mkEnableOption "org layer";

  config = mkIf cfg {
    package.org-bullets.enable = true;
  };
}
