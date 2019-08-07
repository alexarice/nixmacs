{ config, epkgs, lib, ... }:

with lib;

let
  cfg = config.layers.smartparens;
in
{
  options.layers.smartparens = {
    enable = mkEnableOption "Enable smartparens package";

    strict = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Use smartparens-strict-mode
      '';
    };

    hooks = mkOption {
      type = types.separatedString " ";
      default = "";
      description = ''
        hooks to start smartparens on
      '';
    };
  };

  config = mkIf cfg.enable {
    packages = {
      smartparens = let sp-mode = "smartparens-${if cfg.strict then "strict-" else ""}mode";
      in {
        enable = true;

        package = epkgs.melpaPackages.smartparens;

        commands = [ "sp-split-sexp" "sp-newline" "sp-up-sexp" ];

        custom = [
          "(sp-show-pair-delay 0.1)"
          "(sp-show-pair-from-inside t)"
          "(sp-cancel-autoskip-on-backward-movement nil)"
        ];

        diminish = sp-mode;

        hook = "((${cfg.hooks}) . ${sp-mode})";

        config = [
          "(require 'smartparens-config)"
        ];
      };
    };
  };
}
