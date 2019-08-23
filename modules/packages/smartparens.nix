{ config, lib, ... }:

with lib;

{
  config.use-package.smartparens =
  {
    defer = mkDefault true;
    commands = mkDefault [ "sp-split-sexp" "sp-newline" "sp-up-sexp" ];
    custom = {
      sp-show-pair-delay = mkDefault "0.1";
      sp-show-pair-from-inside = mkDefault "t";
      sp-cancel-autoskip-on-backward-movement = mkDefault "nil";
      sp-highlight-pair-overlay = mkDefault "nil";
      sp-highlight-wrap-overlay = mkDefault "nil";
      sp-highlight-wrap-tag-overlay = mkDefault "nil";
    };
    config = mkDefault [
      "(require 'smartparens-config)"
    ];
  };
}
