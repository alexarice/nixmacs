{ config, lib, ... }:

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
        config = [ "(global-flycheck-mode)" ];
      };
    };
  };
}
