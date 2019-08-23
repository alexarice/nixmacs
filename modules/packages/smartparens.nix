{ config, lib, ... }:

with lib;

{
  config.use-package.smartparens =
  {
    defer = mkDefault true;
    commands = mkDefault [ "sp-split-sexp" "sp-newline" "sp-up-sexp" ];
    custom = {
      sp-show-pair-delay = mkDefault "0.1";
      sp-show-pair-from-inside = mkDefault true;
      sp-cancel-autoskip-on-backward-movement = mkDefault false;
      sp-highlight-pair-overlay = mkDefault false;
      sp-highlight-wrap-overlay = mkDefault false;
      sp-highlight-wrap-tag-overlay = mkDefault false;
    };
    config = mkDefault [
      "(require 'smartparens-config)"
    ];
  };
}
