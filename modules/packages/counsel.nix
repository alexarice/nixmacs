{ config, lib, ... }:

with lib;

{
  config.package.counsel.use-package = {
    config = mkDefault  ''
      (counsel-mode 1)
    '';
    diminish = mkDefault "counsel-mode";
  };
}
