{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.packages.rainbow;
in
{
  options.packages.rainbow.enable = mkEnableOption "Rainbow mode";

  config = mkIf cfg.enable {
    use-package = {
      rainbow-mode = {
        enable = true;
        package = epkgs.elpaPackages.rainbow-mode;
        hook = "prog-mode";
      };
    };
  };
}
