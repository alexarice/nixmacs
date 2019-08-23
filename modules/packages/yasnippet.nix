{ config, lib, ... }:

with lib;

{
  config.use-package.yasnippet = {
    commands = mkDefault [ "yas-global-mode" "yas-minor-mode" ];
    hook = mkDefault "(prog-mode . yas-minor-mode)";
  };
}
