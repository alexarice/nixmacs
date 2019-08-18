{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.git;
in
{
  options.layers.git.enable = mkEnableOption "Git layer";

  config = mkIf cfg.enable {
    packages = {
      magit = {
        enable = true;
        package = epkgs.melpaPackages.magit;
      };

      git-gutter = {
        enable = true;
        package = epkgs.melpaPackages.git-gutter;
        diminish = "git-gutter-mode";
        config = [ "(global-git-gutter-mode 1)" ];
      };

      git-timemachine = {
        enable = true;
        package = epkgs.melpaPackages.git-timemachine;
      };
    };
  };
}
