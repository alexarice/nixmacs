{ config, lib, ... }:

with lib;

{
  config.package.powerline.use-package = {
    custom.powerline-default-separator = mkDefault "'utf-8";
    config = mkDefault ''
      (powerline-center-theme)
    '';
  };
}
