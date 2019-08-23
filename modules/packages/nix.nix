{ config, lib, ... }:

with lib;

let
  cfg = config.packages.nix;
in
{
  options.packages.nix = {
    enable = mkEnableOption "Nix Layer";
  };

  config = mkIf cfg.enable {
    use-package = {
      company-nixos-options = {
        enable = config.use-package.company.enable;
        defer = true;
      };

      nix-mode = {
        enable = true;
        mode = "\"\\\\.nix\\\\'\"";
        init = singleton ''
          (setq nix-indent-function 'nix-indent-line)
        '';
      };

      nixos-options = {
        enable = true;
        defer = true;
      };
    };
    packages.company.company-hooks."nix-mode-hook" = [ "company-nixos-options" ];
    packages.parens.hooks = "nix-mode";
  };
}
