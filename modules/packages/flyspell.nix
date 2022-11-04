{ config, lib, pkgs, ... }:

with lib;

{
  config.package.flyspell = {
    use-package = {
      hook = "(text-mode . flyspell-mode)";
      custom = {
        ispell-program-name = ''"aspell"'';
      };
    };
    external-packages = with pkgs; [ aspell ];
    package = mkDefault [];
  };
}
