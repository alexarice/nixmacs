{ config, lib, ... }:

with lib;

let
  cfg = config.layers.nixmacs;
in
{
  options.layers.nixmacs = {
    enable = (mkEnableOption "nixmacs base layer") // { default = true; };
  };

  config = mkIf cfg.enable {
    package = {
      adaptive-wrap.enable = mkDefault true;
      crux.enable = mkDefault true;
      flycheck.enable = mkDefault true;
      neotree.enable = mkDefault true;
      doom-modeline.enable = mkDefault true;
      projectile.enable = mkDefault true;
      rainbow-delimiters.enable = mkDefault true;
      rainbow-mode.enable = mkDefault true;
      undo-tree.enable = mkDefault true;
      which-key.enable = mkDefault true;
      smartparens.enable = mkDefault true;
      smooth-scrolling.enable = mkDefault true;
    };

    settings = {
      line-numbers.enable = mkDefault true;
      delete-trailing-whitespace = mkDefault true;
      crux-C-a = mkDefault true;
      global-hl-line = mkDefault true;
      recent-files-mode = mkDefault true;
    };

    layers.better-defaults.enable = mkDefault true;
    layers.ivy.enable = mkDefault true;
    layers.nix.enable = mkDefault true;
  };
}
