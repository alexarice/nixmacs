{ config, lib, ... }:

with lib;

let
  cfg = config.layers.c;
in
{
  options.layers.c.enable = mkEnableOption "C/C++ layer";

  config = mkIf cfg.enable {
    package = {
      irony.enable = mkDefault true;
      company-irony.enable = mkDefault true;
      company.settings.company-hooks.irony-mode = mkDefault [
        "company-irony"
        "company-dabbrev-code"
      ];
      flycheck-irony.enable = mkDefault true;
      irony-eldoc.enable = mkDefault true;
    };
  };
}
