{ config, lib, ... }:

with lib;

let
  cfg = config.layers.yaml;
in
{
  options.layers.yaml.enable = mkEnableOption "yaml layer";

  config = mkIf cfg.enable {
    package = {
      yaml-mode.enable = true;

      company.settings.company-hooks.yaml-mode = [ "company-files" "company-dabbrev" ];
    };
  };
}
