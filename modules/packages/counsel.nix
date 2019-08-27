{ config, lib, ... }:

with lib;

{
  config.package.counsel = {
    config = mkDefault (singleton ''
      (counsel-mode 1)
    '');
    diminish = mkDefault "counsel-mode";
  };
}
