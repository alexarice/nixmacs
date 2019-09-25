{ config, lib, ... }:

with lib;

let
  cfg = config.package.xah-fly-keys.settings;
  printXahBinds = c: concatStringsSep "\n  " (mapAttrsToList (name: value: "(define-key xah-fly-key-map (kbd ${name}) '${value})") c);
  printInsertBinds = c: concatStringsSep "\n  " (mapAttrsToList (name: value: "(define-key xah-fly-key-map (kbd ${name}) nil)") c);
  modes = attrNames config.keybindings.major-mode;
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

    major-mode-bind-key = mkOption {
      type = with types; nullOr str;
      default = null;
      description = ''
        Key to bind major mode bindings to.
      '';
    };
  };

  config.package = {
    xah-fly-keys = {
      use-package = {
        demand = mkDefault true;
        config = mkMerge ([
          (mkDefault ''
            (xah-fly-keys-set-layout "${cfg.keyboard-layout}")

            (defun my-bindkey-xfk-command-mode ()
              "Define keys for `xah-fly-command-mode-activate-hook'"
              (interactive)
              ${printXahBinds cfg.command-mode-bindings})

            (defun my-bindkey-xfk-insert-mode ()
              "Reset bindings for insert mode"
              (interactive)
              ${printInsertBinds cfg.command-mode-bindings})

            (add-hook 'xah-fly-command-mode-activate-hook 'my-bindkey-xfk-command-mode)
            (add-hook 'xah-fly-insert-mode-activate-hook 'my-bindkey-xfk-insert-mode)
            (xah-fly-keys 1)
          '')
          (mkIf (cfg.major-mode-bind-key != null) (mkDefault ''
            ${concatStringsSep "\n" (map (x: "(define-prefix-command 'leader-${x}-map)") modes)}

            ${concatStringsSep "\n" (mapAttrsToList (name: value: printGeneral {
              keymaps = "leader-${name}-map";
              binds = value;
            }) (config.keybindings.major-mode))}

            (defun major-mode-bindings ()
              (interactive)
              (cond ${concatStringsSep " " (map (x: "((string-equal major-mode \"${x}\") (set-transient-map leader-${x}-map))") modes)} (t nil)))

            (define-key xah-fly-leader-key-map (kbd "${cfg.major-mode-bind-key}") 'major-mode-bindings)
          ''))
        ]);
      };
      settings.command-mode-bindings = {
        # TODO: Make these eval in nix
        "(xah-fly--key-char \"a\")" = mkIf config.package.counsel.enable (mkDefault "counsel-M-x");
        "(xah-fly--key-char \"b\")" = mkIf config.package.swiper.enable (mkDefault "swiper");
      };
    };
    general.enable = mkIf (cfg.major-mode-bind-key != null) true;
  };
}
