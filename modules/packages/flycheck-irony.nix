{ config, lib,  ... }:

with lib;

{
  config.package.flycheck-irony = {
    defer = mkDefault true;
    commands = mkDefault (singleton "flycheck-irony-setup");
    config = mkDefault ''
      (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
    '';
  };
}
