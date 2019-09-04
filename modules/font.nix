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
      example = "Source Code Pro 9";
      description = ''
        Font string to use or null to not set font.
      '';
    };

    unicode-font = mkOption {
      type = with types; nullOr str;
      default = null;
      example = "STIXGeneral";
      description = ''
        Unicode font string to use or null to not set unicode font.
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
