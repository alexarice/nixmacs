{ config, lib, pkgs, epkgs, ... }:

with lib;

{
  package.irony = {
    external-packages = mkDefault [ pkgs.irony-server ];
    use-package = {
      hook = mkDefault "((c++-mode c-mode) . irony-mode)";
      config = mkDefault ''
        (require 'irony-cdb)
        (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
      '';
    };
  };
}
