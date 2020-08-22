{ config, lib, ... }:

with lib;

let
  cfg = config.package.lsp-mode.settings;
in
{
  options.package = add-settings "lsp-mode" {
    deferred = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to use lsp-deferred.
      '';
    };

    lsp-hooks = mkOption {
      type = with types; (listOf str);
      default = [];
      description = ''
        Modes to activate lsp in.
      '';
    };
  };

  config.package.lsp-mode.use-package = let
    command = "lsp${if cfg.deferred then "-deferred" else ""}";
  in {
    hook = mkDefault "((${concatStringsSep " " cfg.lsp-hooks}) . ${command})";
    commands = mkDefault [ "${command}" ];
    diminish = mkDefault "lsp-mode";
  };
}
