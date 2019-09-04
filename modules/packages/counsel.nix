{ config, lib, ... }:

with lib;

{
  package.counsel.use-package = {
    config = mkDefault ''
      (counsel-mode 1)
    '';
    diminish = mkDefault "counsel-mode";
  };
}
