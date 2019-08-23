{ config, lib, ... }:

with lib;

{
  config.use-package.powerline = {
    custom.powerline-default-separator = mkDefault "'utf-8";
    config = mkDefault (singleton ''
      (powerline-center-theme)
    '');
  };
}
