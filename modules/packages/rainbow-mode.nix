{ config, lib, ... }:

with lib;

{
  config.package.rainbow-mode = {
    hook = mkDefault "prog-mode";
    diminish = "rainbow-mode";
  };
}
