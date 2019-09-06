{ config, lib, ... }:

with lib;

let
  cfg = config.package.xah-fly-keys.settings;
  printXahBinds = c: concatStringsSep "\n  " (mapAttrsToList (name: value: "(define-key xah-fly-key-map (kbd ${name}) '${value})") c);
in
{
  options.package.xah-fly-keys.settings = {
    keyboard-layout = mkOption {
      type = types.enum [
        "azerty"
        "azerty-be"
        "colemak"
        "colemak-mod-dh"
        "dvorak"
        "programer-dvorak"
        "qwerty"
        "qwerty-abnt"
        "qwertz"
        "workman"
      ];
      default = "qwerty";
      example = "dvorak";
      description = ''
        Keyboard layout to be passed to xah-fly-keys.
      '';
    };

    command-mode-bindings = mkOption {
      type = with types; attrsOf str;
      default = {};
      description = ''
        Extra keybindings for command mode.
      '';
    };
  };

  config.package.xah-fly-keys = {
    use-package = {
      demand = mkDefault true;
      config = mkDefault ''
        (xah-fly-keys-set-layout "${cfg.keyboard-layout}")
        (defun my-bindkey-xfk-command-mode ()
          "Define keys for `xah-fly-command-mode-activate-hook'"
          (interactive)
          ${printXahBinds cfg.command-mode-bindings})
        (add-hook 'xah-fly-command-mode-activate-hook 'my-bindkey-xfk-command-mode)
        (xah-fly-keys 1)
      '';
    };
    settings.command-mode-bindings = {
      # TODO: Make these eval in nix
      "(xah-fly--key-char \"a\")" = mkIf config.package.counsel.enable (mkDefault "counsel-M-x");
      "(xah-fly--key-char \"b\")" = mkIf config.package.swiper.enable (mkDefault "swiper");
    };
  };
}
