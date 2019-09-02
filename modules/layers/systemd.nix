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
    package.systemd.enable = true;
    layers.completion.company-hooks.systemd-mode-hook = [ "(company-files) (company-systemd-backend) (company-dabbrev-code company-capf)" ];
  };
}
