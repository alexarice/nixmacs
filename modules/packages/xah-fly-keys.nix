{ config, lib, ... }:

with lib;

let
  cfg = config.package.xah-fly-keys.settings;
  printXahBinds = c: concatStringsSep "\n    " (mapAttrsToList (name: value: "(\"${name}\" . ${value})") c);
  bindings = attrValues config.keybindings.major-mode;
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
            (xah-fly--define-keys
              xah-fly-command-map
              '(${printXahBinds cfg.command-mode-bindings})
              :direct)
            (defun my-bindkey-xfk-command-mode ()
              "Define keys for `xah-fly-command-mode-activate-hook'"
              (interactive)
              (setq command-mode t))
            (defun my-bindkey-xfk-insert-mode ()
              "Reset bindings for insert mode"
              (interactive)
              (setq command-mode nil))

            (add-hook 'xah-fly-command-mode-activate-hook 'my-bindkey-xfk-command-mode)
            (add-hook 'xah-fly-insert-mode-activate-hook 'my-bindkey-xfk-insert-mode)
            (xah-fly-keys 1)
          '')
          (mkIf (cfg.major-mode-bind-key != null) (mkDefault ''
            (define-key
              xah-fly-leader-key-map
              (kbd "${cfg.major-mode-bind-key}") nil)
            ${concatStringsSep "\n" (map (x: ''
              (define-prefix-command 'leader-${x.name}-sub-map)
              ${printGeneral {
                  keymaps = "leader-${x.name}-sub-map";
                  binds = x.binds;
              }}

              (setq leader-${x.name}-map (let ((map (make-sparse-keymap)))
                (set-keymap-parent map xah-fly-leader-key-map)
                (define-key map (kbd "${cfg.major-mode-bind-key}") ${x.command})
                (let ((map-main (make-sparse-keymap)))
                  (define-key map-main (kbd "SPC") map)
                  map-main)))
              (add-hook '${x.name}-hook (lambda () (add-to-list 'minor-mode-overriding-map-alist (cons 'command-mode leader-${x.name}-map))))
            '') (filter (x: x.binds != null) bindings))}
          ''))
        ]);
      };
      settings.command-mode-bindings = {
        # TODO: Make these eval in nix
        "a" = mkIf config.package.counsel.enable (mkDefault "counsel-M-x");
        "b" = mkIf config.package.swiper.enable (mkDefault "swiper");
      };
    };
    general.enable = mkIf (cfg.major-mode-bind-key != null) true;
  };
}
