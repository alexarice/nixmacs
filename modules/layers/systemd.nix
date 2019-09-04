{ config, lib, ... }:

with lib;

let
  cfg = config.layers.systemd;
in
{
  options.layers.systemd = {
    enable = mkEnableOption "systemd layer";
  };

  config = mkIf cfg.enable {
    package = {
      systemd.enable = true;
      # Appears to be broken
      flycheck.settings.disabled-checkers = [ "systemd-analyze" ];
      company.settings.company-hooks.systemd-mode-hook = [ "(company-files) (systemd-company-backend) (company-dabbrev-code company-capf)" ];
    };
  };
}
