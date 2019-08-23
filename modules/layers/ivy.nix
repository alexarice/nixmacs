{ config, lib, ... }:

with lib;

let
  cfg = config.layers.ivy;
in
{
  options.layers = {
    ivy = {
      enable = mkEnableOption "Ivy layer";
    };
  };

  config = mkIf cfg.enable {
    use-package = {
      ivy = {
        enable = true;
        config = singleton ''
          (ivy-mode 1)
        '';
        diminish = "ivy-mode";
        custom = [
          "(ivy-initial-inputs-alist nil)"
          "(ivy-use-selectable-prompt t)"
        ];
        bind."ivy-minibuffer-map"."RET" = "ivy-alt-done";
      };
      counsel = {
        enable = true;
        config = singleton ''
          (counsel-mode 1)
        '';
        diminish = "counsel-mode";
      };
      swiper = {
        enable = true;
        bind."C-s" = "swiper";
      };
      counsel-projectile = {
        enable = config.use-package.projectile.enable;
      };
      projectile = {
        custom = [ "(projectile-completion-system 'ivy)" ];
      };
      smex = {
        enable = true;
      };
    };
  };
}
