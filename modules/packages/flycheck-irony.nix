{ config, lib, ... }:

with lib;

{
  package.flycheck-irony.use-package = {
    defer = mkDefault true;
    commands = mkDefault (singleton "flycheck-irony-setup");
    config = mkDefault ''
      (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
    '';
  };
}
