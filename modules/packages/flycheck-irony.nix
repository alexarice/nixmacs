{ config, lib,  ... }:

with lib;

{
  config.use-package.flycheck-irony = {
    defer = mkDefault true;
    commands = mkDefault (singleton "flycheck-irony-setup");
    config = mkDefault (singleton ''
      (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
    '');
  };
}
