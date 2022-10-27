{ config, lib, ... }:

with lib;

let
  cfg = config.layers.treemacs;
in
{
  options.layers = {
    treemacs = {
      enable = mkEnableOption "treemacs layer";
    };
  };

  config = mkIf cfg.enable {
    package = {
      treemacs.enable = mkDefault true;
      treemacs-projectile.enable = mkDefault true;
      treemacs-magit.enable = mkDefault true;
      lsp-treemacs.enable = mkIf config.layers.lsp.enable (mkDefault true);
    };
  };
}
