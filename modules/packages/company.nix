{ config, lib, ... }:

with lib;

let
  cfg = config.package.company.settings;
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
  options.package.company.settings.company-hooks = mkOption {
    type = with types; attrsOf (uniq (listOf str));
    default = {};
    description = ''
      Company backends for major modes.
    '';
  };

  config.package.company.use-package = {
    custom = {
      company-idle-delay = mkDefault 0;
      company-minimum-prefix-length = mkDefault 2;
      company-selection-wrap-around = mkDefault true;
    };
    config = mkDefault ''
      (progn
      ${writeAllHooks (cfg.company-hooks)}
      (global-company-mode 1)
      )
    '';
    diminish = "company-mode";
  };
}
