{ config, lib, pkgs,  ... }:

with lib;

{
  config.use-package.irony = {
    external-packages = mkDefault [ pkgs.irony-server ];
    hook = mkDefault "((c++-mode c-mode) . irony-mode)";
    custom.irony-cdb-compilation-databases = "'(irony-cdb-libclang irony-cdb-clang-complete)";
    config = mkDefault (singleton ''
      (add-hook 'irony-mode-hook 'irony-cbd-autosetup-compile-options)
    '');
  };
}
