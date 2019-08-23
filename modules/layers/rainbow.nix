{ config, lib, ... }:

with lib;

let
  cfg = config.layers.rainbow;
in
{
  options.layers.rainbow.enable = mkEnableOption "Rainbow mode";

  config = mkIf cfg.enable {
    use-package = {
      rainbow-mode = {
        enable = true;
        hook = "prog-mode";
      };
    };
  };
}
