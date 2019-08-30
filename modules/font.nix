{ config, lib, ... }:

with lib;

let
  cfg = config.appearance.fonts;
in
{
  options.appearance.fonts = {
    font = mkOption {
      type = with types; nullOr str;
      default = null;
      description = ''
        Font string or null to not set
      '';
    };

    unicode-font = mkOption {
      type = with types; nullOr str;
      default = null;
      description = ''
        Unicode font string or null to not set
      '';
    };
  };

  config.init-el.preamble = mkMerge [
    (
      mkIf (cfg.font != null) ''
        (set-frame-font "${cfg.font}" nil t)
      ''
    )
    (
      mkIf (cfg.unicode-font != null) ''
        (set-fontset-font t 'unicode "${cfg.unicode-font}" nil 'prepend)
      ''
    )
  ];
}
