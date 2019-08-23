{ config, lib, ... }:

with lib;

let
  cfg = config.appearance.font;
in
{
  options.appearance.font = mkOption{
    type = with types; nullOr str;
    default = null;
    description = ''
      Font string or null to not set
    '';
  };

  config = mkIf (cfg != null) {
    init-el.preamble = ''
      (add-to-list 'default-frame-alist '(font . "${cfg}"))
    '';
  };
}
