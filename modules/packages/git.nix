{ config, lib, ... }:

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
      };

      git-gutter = {
        enable = true;
        diminish = "git-gutter-mode";
        config = [ "(global-git-gutter-mode 1)" ];
      };

      git-timemachine = {
        enable = true;
      };
    };
  };
}
