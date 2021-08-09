{ config, pkgs, lib, ... }:

with lib;

let
  cfg-lsp = config.package.lsp-mode.enable;
in
{
  package.rustic = {
    external-packages = mkIf cfg-lsp [ pkgs.rust-analyzer pkgs.cargo pkgs.rustc ];
  };
}
