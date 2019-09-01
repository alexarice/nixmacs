{ config, lib, ... }:

with lib;

{
  config.package.js2-refactor.use-package = {
    hook = mkDefault "(js2-mode . js2-refactor-mode)";
    bind.js2-mode-map."C-k" = mkDefault "js2r-kill";
    config = mkDefault ''
      (js2r-add-keybindings-with-prefix "C-c C-r")
    '';
  };
}
