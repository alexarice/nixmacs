{ config, lib, ... }:

with lib;

let
  inherit (builtins) concatStringsSep attrNames getAttr;
  cfg = config.layers.company;
  default = cfg.default-backends;
  writeCompanyHook = name: backends: ''
    (add-hook '${name}
    (lambda ()
    (set (make-local-variable 'company-backends) '(${concatStringsSep " " (backends ++ default)}))))
  '';
  writeAllHooks = s:
  let
    hooks = attrNames s;
  in
  concatStringsSep "\n" (map (x: writeCompanyHook x (getAttr x s)) hooks);
in
{

  options.layers.company = {
    enable = mkEnableOption "company Layer";

    yas-expand-key = mkOption {
      type = types.str;
      default = "TAB";
      description = ''
        Binding for yas-expand
      '';
    };

    yas-snippet-dirs = mkOption {
      type = types.str;
      default = "(list (concat user-emacs-directory \"snippets/\"))";
      description = ''
        yasnippet snippet directory
      '';
    };

    company-hooks = mkOption {
      type = with types; attrsOf (listOf str);
      default = {};
      description = ''
        company backends for major modes
      '';
    };

    default-backends = mkOption {
      type = with types; listOf str;
      default = [
        "company-dabbrev"
        "company-bbdb"
        "company-oddmuse"
        "company-eclim"
        "company-semantic"
        "company-xcode"
        "company-cmake"
        "company-capf"
        "company-files"
        "(company-dabbrev-code company-gtags company-etags company-keywords)"
      ];
    };
  };

  config = {
    use-package = {
      yasnippet = {
        enable = true;
        commands = [ "yas-global-mode" "yas-minor-mode" ];
        bind."yas-minor-mode-map" =
          if cfg.yas-expand-key == "TAB" then {} else {
            "TAB" = "nil";
            "<tab>" = "nil";
            "${cfg.yas-expand-key}" = "yas-expand";
          };
        init = singleton "(add-hook 'prog-mode-hook #'yas-minor-mode)";
        custom.yas-snippet-dirs = "${cfg.yas-snippet-dirs}";
      };

      auto-yasnippet = {
        enable = true;
        bind."${cfg.yas-expand-key}" = "aya-expand";
      };

      company = {
        enable = true;
        init = singleton ''
          (setq company-idle-delay 0.1
                company-minimum-prefix-length 2
                company-selection-wrap-around t)
              '';
        config = singleton ''
          (progn
          ${writeAllHooks (cfg.company-hooks)}
          (global-company-mode 1)
          )
        '';
      };
    };
  };
}
