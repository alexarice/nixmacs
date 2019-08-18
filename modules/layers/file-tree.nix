{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.file-tree;
in
{
  options.layers.file-tree = {
    enable = mkEnableOption "File tree layer";

    neo-theme = mkOption {
      type = types.str;
      default = "arrow";
      description = ''
        neo-theme variable
      '';
    };
  };

  config = mkIf cfg.enable {
    packages = {
      neotree = {
        enable = true;
        package = epkgs.melpaPackages.neotree;
        custom = [
          "(neo-smart-open t)"
          "(neo-theme '${cfg.neo-theme})"
        ];
      };
    };
  };
}
