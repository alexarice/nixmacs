{ config, lib, ... }:

with lib;

{
  config.package.auctex-latexmk.use-package = {
    defer = mkDefault true;
    commands = singleton "auctex-latexmk-setup";
    custom.auctex-latexmk-inherit-TeX-PDF-mode = mkDefault true;
  };
}
