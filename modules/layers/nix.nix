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
      company-nixos-options.enable = mkDefault config.package.company.enable;

      company.settings.company-hooks.nix-mode = mkDefault [
        "company-files"
        "(company-nixos-options company-capf company-dabbrev-code)"
      ];

      nix-repl.enable = mkDefault true;

      nix-drv-mode.enable = mkDefault true;

      nix-shell.enable = mkDefault true;

      nix-mode.enable = mkDefault true;

      nixos-options.enable = mkDefault true;
    };

    keybindings.major-mode.nix-mode = {
      r = "nix-repl";
    };
  };
}
