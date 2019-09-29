{ config, lib, ... }:

with lib;

let
  cfg = config.custom;
in
{
  options.custom = {
    enable = mkEnableOption "emacs customisation";

    file = mkOption {
      type = with types; either str path;
      default = "~/.emacs.d/custom.el";
      description = ''
        File to save emacs customisations in.
      '';
    };
  };

  config = mkIf cfg.enable {
    settings.global-variables.custom-file = "\"${cfg.file}\"";

    init-el.postSetup = ''
      (load custom-file)
    '';
  };
}
