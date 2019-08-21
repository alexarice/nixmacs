{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.flycheck;
in
{
  options.layers.flycheck = {
    enable = mkEnableOption "Enable Flycheck";
  };

  config = mkIf cfg.enable {
    use-package = {
      flycheck = {
        enable = true;
        package = epkgs.melpaPackages.flycheck;
        config = [ "(global-flycheck-mode)" ];
      };
    };
  };
}
