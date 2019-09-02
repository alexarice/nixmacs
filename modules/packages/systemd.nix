{ config, lib, epkgs, ... }:

with lib;

{
  config.package.systemd = {
    package = epkgs.systemd.overrideAttrs (old: { patches = [ ./systemd/fix_autoload.patch ]; });
    use-package = {
      defer = mkDefault true;
    };
  };
}
