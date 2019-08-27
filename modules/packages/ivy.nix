{ config, lib, ... }:

with lib;

{
  config.package.ivy = {
    config = mkDefault (singleton ''
      (ivy-mode 1)
    '');
    diminish = mkDefault "ivy-mode";
    custom = {
      ivy-initial-inputs-alist = mkDefault false;
      ivy-use-selectable-prompt = mkDefault true;
    };
    bind."ivy-minibuffer-map"."RET" = mkDefault "ivy-alt-done";
  };
}
