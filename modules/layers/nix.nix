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
    use-package = {
      company-nixos-options = {
        enable = config.use-package.company.enable;
        package = epkgs.melpaPackages.company-nixos-options;
        defer = true;
      };

      nix-mode = {
        enable = true;
        mode = "\"\\\\.nix\\\\'\"";
        package = epkgs.melpaPackages.nix-mode;
        init = singleton ''
          (setq nix-indent-function 'nix-indent-line)
        '';
      };

      nixos-options = {
        enable = true;
        package = epkgs.melpaPackages.nixos-options;
        defer = true;
      };
    };
    layers.auto-complete.company-hooks."nix-mode-hook" = [ "company-nixos-options" ];
    layers.parens.hooks = "nix-mode";
  };
}
