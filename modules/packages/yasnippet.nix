{ config, lib, ... }:

with lib;

{
  config.package.yasnippet.use-package = {
    commands = mkDefault [ "yas-global-mode" "yas-minor-mode" ];
    hook = mkDefault "(prog-mode . yas-minor-mode)";
    diminish = "yas-minor-mode";
  };
}
