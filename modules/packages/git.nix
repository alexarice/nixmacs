{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.packages.git;
in
{
  options.packages.git.enable = mkEnableOption "Git layer";

  config = mkIf cfg.enable {
    use-package = {
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
