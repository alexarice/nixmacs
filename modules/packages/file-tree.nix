{ config, lib, ... }:

with lib;

let
  cfg = config.packages.file-tree;
in
{
  options.packages.file-tree = {
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
    use-package = {
      neotree = {
        enable = true;
        custom = [
          "(neo-smart-open t)"
          "(neo-theme '${cfg.neo-theme})"
        ];
      };
    };
  };
}
