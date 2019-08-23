{ config, lib, ... }:

with lib;

{
  config.use-package.rainbow-mode = {
    hook = mkDefault "prog-mode";
    diminish = "rainbow-mode";
  };
}
