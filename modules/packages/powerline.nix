{ config, lib, ... }:

with lib;

{
  config.package.powerline = {
    custom.powerline-default-separator = mkDefault "'utf-8";
    config = mkDefault ''
      (powerline-center-theme)
    '';
  };
}
