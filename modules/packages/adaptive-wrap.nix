{ config, lib, ... }:

with lib;

let
  cfg = config.package.adaptive-wrap.settings;
in
{
  options.package.adaptive-wrap.settings = {
    indent = mkOption {
      type = types.int;
      default = 2;
      description = ''
        Adaptive wrap indent variable.
      '';
    };
  };

  config.package.adaptive-wrap = {
    use-package = {
      config = mkDefault ''
        (setq-default adaptive-wrap-extra-indent ${builtins.toString cfg.indent})
        (add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode)
        (global-visual-line-mode 1)
      '';
      diminish = mkDefault "visual-line-mode";
    };
  };
}
