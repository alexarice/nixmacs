{ config, lib, ... }:

with lib;

let
  cfg = config.layers.git;
in
{
  options.layers.git.enable = mkEnableOption "Git layer";

  config = mkIf cfg.enable {
    use-package = {
      magit = {
        enable = true;
      };

      git-gutter = {
        enable = true;
      };

      git-timemachine = {
        enable = true;
      };
    };
  };
}
