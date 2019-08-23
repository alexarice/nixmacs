{ config, lib, ... }:

with lib;

let
  cfg = config.layers.nix;
in
{
  options.layers.nix = {
    enable = mkEnableOption "Nix Layer";
  };

  config = mkIf cfg.enable {
    use-package = {
      company-nixos-options = {
        enable = config.use-package.company.enable;
      };

      nix-mode = {
        enable = true;
      };

      nixos-options = {
        enable = true;
      };
    };
    layers.completion.company-hooks."nix-mode-hook" = [ "company-nixos-options" ];
  };
}
