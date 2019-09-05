{ config, lib, ... }:

with lib;

let
  cfg = config.package.xah-fly-keys.settings;
in
{
  options.package.xah-fly-keys.settings = {
    keyboard-layout = mkOption {
      type = types.enum [
        "azerty"
        "azerty-be"
        "colemak"
        "colemak-mod-dh"
        "dvorak"
        "programer-dvorak"
        "qwerty"
        "qwerty-abnt"
        "qwertz"
        "workman"
      ];
      default = "qwerty";
      example = "dvorak";
      description = ''
        Keyboard layout to be passed to xah-fly-keys.
      '';
    };
  };

  config.package.xah-fly-keys = {
    use-package = {
      config = mkDefault ''
        (xah-fly-keys-set-layout "${cfg.keyboard-layout}")
        (xah-fly-keys 1)
      '';
    };
  };
}
