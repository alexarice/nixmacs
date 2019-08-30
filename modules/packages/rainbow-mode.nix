{ config, lib, ... }:

with lib;

{
  config.package.rainbow-mode.use-package = {
    hook = mkDefault "prog-mode";
    diminish = "rainbow-mode";
  };
}
