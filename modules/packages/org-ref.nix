{ config, lib, ... }:

with lib;

let
  cfg = config.package.org-ref.settings;
in
{
  options.package = add-settings "org-ref" {
    bibliography = mkOption {
      type = types.str;
      description = ''
        Bibliography file for org-ref
      '';
    };
  };

  config.package.org-ref = {
    use-package = {
      custom = {
        org-ref-default-bibliography = mkDefault cfg.bibliography;
        bibtex-completion-bibliography = mkDefault cfg.bibliography;
      };
    };
  };
}
