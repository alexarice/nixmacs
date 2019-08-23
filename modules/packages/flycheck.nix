{ config, lib, ... }:

with lib;

let
  cfg = config.packages.flycheck;
in
{
  options.packages.flycheck = {
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
