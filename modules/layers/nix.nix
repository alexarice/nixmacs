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
    package = {
      company-nixos-options = {
        enable = config.package.company.enable;
      };

      nix-repl.enable = true;

      nix-drv-mode.enable = true;

      nix-shell.enable = true;

      nix-mode.enable = true;

      nixos-options.enable = true;
    };

    layers.completion.company-hooks."nix-mode-hook" = [ "company-files" "(company-nixos-options company-capf company-dabbrev-code)" ];
  };
}
