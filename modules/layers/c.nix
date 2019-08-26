{ config, lib, ... }:

with lib;

let
  cfg = config.layers.c;
in
{
  options.layers.c.enable = mkEnableOption "C/C++ layer";

  config = mkIf cfg.enable {
    use-package = {
      irony.enable = true;
      company-irony.enable = true;
      flycheck-irony.enable = true;
      irony-eldoc.enable = true;
    };

    layers.completion.company-hooks.irony-mode-hook = [ "company-irony" ];
  };
}
