{ config, lib, ... }:

with lib;

let
  cfg = config.layers.notmuch;
in
{
  options.layers.notmuch = {
    enable = mkEnableOption "notmuch email interface";
  };

  config = mkIf cfg.enable {
    package = {
      notmuch.enable = true;
      counsel-notmuch.enable = mkIf config.layers.ivy.enable true;
    };
  };
}
