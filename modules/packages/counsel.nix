{ config, lib, ... }:

with lib;

{
  config.use-package.counsel = {
    config = mkDefault (singleton ''
      (counsel-mode 1)
    '');
    diminish = mkDefault "counsel-mode";
  };
}
