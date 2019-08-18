{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.rainbow;
in
{
  options.layers.rainbow.enable = mkEnableOption "Rainbow mode";

  config = mkIf cfg.enable {
    packages = {
      rainbow-mode = {
        enable = true;
        package = epkgs.elpaPackages.rainbow-mode;
        hook = "prog-mode";
      };
    };
  };
}
