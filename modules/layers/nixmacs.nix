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
    use-package.neotree = {
      enable = mkDefault true;
      neo-theme = "'${cfg.neo-theme}";
    };
  };
}
