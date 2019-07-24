{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.nix;
in
{
  options.layers.nix = {
    enable = mkEnableOption "Nix Layer";
  };

  config = mkIf cfg.enable {
    packages = {
      company-nixos-options = {
        enable = config.packages.company.enable;
        package = epkgs.melpaPackages.company-nixos-options;
        defer = true;
      };

      nix-mode = {
        enable = true;
        mode = "\"\\\\.nix\\\\'\"";
        package = epkgs.melpaPackages.nix-mode;
      };

      nixos-options = {
        enable = true;
        package = epkgs.melpaPackages.nixos-options;
      };
    };
    layers.auto-complete.company-hooks."nix-mode-hook" = [ "company-nixos-options" ];
  };
}