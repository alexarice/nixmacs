{ config, lib, ... }:

with lib;

let
  cfg = config.layers.c;
in
{
  options.layers.c.enable = mkEnableOption "C/C++ layer";

  config = mkIf cfg.enable {
    package = {
      irony.enable = true;
      company-irony.enable = true;
      company.settings.company-hooks.irony-mode-hook = [ "company-irony" "company-dabbrev-code" ];
      flycheck-irony.enable = true;
      irony-eldoc.enable = true;
    };
  };
}
