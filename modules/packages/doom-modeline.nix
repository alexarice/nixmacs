{ config, lib, ... }:

with lib;

{
  package.doom-modeline.use-package = {
    custom = {
      doom-themes-enable-bold = mkDefault true;
      doom-themes-enable-italic = mkDefault true;
    };
    config = mkDefault ''
      (doom-modeline-mode 1)
    '';
  };
}
