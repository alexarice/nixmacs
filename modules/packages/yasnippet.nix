{ config, lib, ... }:

with lib;

let
  cfg = config.package.yasnippet.settings;
in
{
  options.package = add-settings "yasnippet" {
    yas-snippet-dirs = mkOption {
      type = types.str;
      default = "(list (concat user-emacs-directory \"snippets/\"))";
      description = ''
        Yasnippet snippet directory.
      '';
    };
  };

  config.package.yasnippet.use-package = {
    commands = mkDefault [ "yas-global-mode" "yas-minor-mode" ];
    hook = mkDefault "(prog-mode . yas-minor-mode)";
    diminish = "yas-minor-mode";
    custom.yas-snippet-dirs = "${cfg.yas-snippet-dirs}";
  };
}
