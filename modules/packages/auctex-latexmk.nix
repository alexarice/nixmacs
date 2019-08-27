{ config, lib, ... }:

with lib;

{
  config.use-package.auctex-latexmk = {
    defer = mkDefault true;
    commands = singleton "auctex-latexmk-setup";
    custom.auctex-latexmk-inherit-TeX-PDF-mode = mkDefault true;
  };
}
