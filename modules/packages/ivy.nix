{ config, lib, ... }:

with lib;

{
  config.use-package.ivy = {
    config = mkDefault (singleton ''
      (ivy-mode 1)
    '');
    diminish = mkDefault "ivy-mode";
    custom = {
      ivy-initial-inputs-alist = mkDefault "nil";
      ivy-use-selectable-prompt = mkDefault "t";
    };
    bind."ivy-minibuffer-map"."RET" = mkDefault "ivy-alt-done";
  };
}
