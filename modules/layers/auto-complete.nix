{ config, lib, epkgs, ... }:

with lib;

let
  inherit (builtins) concatStringsSep attrNames getAttr;
  cfg = config.layers.auto-complete;
  writeCompanyHook = name: backends: ''
    (add-hook '${name}
    (lambda ()
    (set (make-local-variable 'company-backends) '(${concatStringsSep " " backends}))))
  '';
  writeAllHooks = s:
  let
    hooks = attrNames s;
  in
  concatStringsSep "\n" (map (x: writeCompanyHook x (getAttr x s)) hooks);
in
{
  options.layers.auto-complete = {
    enable = mkEnableOption "Auto-complete Layer";

    yas-expand-key = mkOption {
      type = types.str;
      default = "TAB";
      description = ''
        Binding for yas-expand
      '';
    };

    company-hooks = mkOption {
      type = with types; loaOf (listOf str);
      default = {};
      description = ''
        company backends for major modes
      '';
    };
  };

  config = {
    packages = {
      yasnippet = {
        enable = true;
        package = epkgs.elpaPackages.yasnippet;
        commands = [ "yas-global-mode" "yas-minor-mode" ];
        bind."yas-minor-mode-map" =
          if cfg.yas-expand-key == "TAB" then {} else {
            "TAB" = "nil";
            "${cfg.yas-expand-key}" = "yas-maybe-expand";
          };
        config = ''
          (yas-global-mode 1)
        '';
      };

      auto-yasnippet = {
        enable = true;
        package = epkgs.melpaPackages.auto-yasnippet;
        bind."${cfg.yas-expand-key}" = "aya-expand";
      };

      company = {
        enable = true;
        package = epkgs.melpaPackages.company;
        defer = true;
        init = ''
          (setq company-idle-delay 0.1
                company-minimum-prefix-length 2
                company-selection-wrap-around t)
              '';
        config = ''
          (progn
          ${writeAllHooks (cfg.company-hooks)}
          )
        '';
      };
    };
  };
}
