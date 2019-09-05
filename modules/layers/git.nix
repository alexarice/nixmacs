{ config, lib, ... }:

with lib;

let
  cfg = config.layers.git;
in
{
  options.layers.git.enable = mkEnableOption "git layer";

  config = mkIf cfg.enable {
    package = {
      magit.enable = mkDefault true;

      git-gutter.enable = mkDefault true;

      git-timemachine.enable = mkDefault true;
    };
  };
}
