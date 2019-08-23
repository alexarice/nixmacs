{ config, lib, ... }:

with lib;

{
  config.use-package.auctex-latexmk = {
    defer = mkDefault true;
    custom.auctex-latexmk-inherit-TeX-PDF-mode = mkDefault "t";
  };
}
