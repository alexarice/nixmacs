{ config, lib, ... }:

with lib;

{
  config.package.counsel = {
    config = mkDefault  ''
      (counsel-mode 1)
    '';
    diminish = mkDefault "counsel-mode";
  };
}
