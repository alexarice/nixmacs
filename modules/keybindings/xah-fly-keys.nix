{ config, lib, packageOptions, ... }:

with lib;

let
  cfg = config.keybindings.xah-fly-keys;
in
{
  options.keybindings.xah-fly-keys = {
    enable = mkEnableOption "xah-fly-keys";

    keyboard-layout = packageOptions.xah-fly-keys.settings.keyboard-layout;
  };

  config = mkIf cfg.enable {
    package.xah-fly-keys = {
      enable = true;

      settings.keyboard-layout = cfg.keyboard-layout;
    };
  };
}
