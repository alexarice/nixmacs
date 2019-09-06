{ config, lib, ... }:

with lib;

{
  package.unicode-fonts.use-package = {
    config = mkDefault ''
      (unicode-fonts-setup)
    '';
  };
}
