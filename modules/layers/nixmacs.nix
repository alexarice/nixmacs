{ config, lib, ... }:

with lib;

let
  cfg = config.layers.nixmacs;
in
{
  options.layers.nixmacs = {
    enable = (mkEnableOption "Nixmacs base layer") // { default = true; };

    neo-theme = mkOption {
      type = types.str;
      default = "arrow";
      description = ''
        neo-theme variable
      '';
    };
  };

  config = mkIf cfg.enable {
    use-package = {
      neotree = {
        enable = mkDefault true;
        custom.neo-theme = mkDefault "'${cfg.neo-theme}";
      };
      projectile.enable = mkDefault true;
      powerline.enable = mkDefault true;
    };
    layers.ivy.enable = mkDefault true;
  };
}
