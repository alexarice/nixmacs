{ config, lib, ... }:

with lib;

{
  package.rainbow-mode.use-package = {
    hook = mkDefault "prog-mode";
    diminish = "rainbow-mode";
  };
}
