{ config, lib, ... }:

with lib;

let
  cfg = config.layers.parens;
in
{
  options.layers.parens = {
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

    rainbow-delimiters = mkOption {
      type = types.bool;
      default = true;
      description = ''
        enable rainbow delimiters
      '';
    };
  };

  config = mkIf cfg.enable {
    use-package = {
      smartparens = let sp-mode = "smartparens-${if cfg.strict then "strict-" else ""}mode";
      in {
        enable = true;
        commands = [ "sp-split-sexp" "sp-newline" "sp-up-sexp" ];
        custom = [
          "(sp-show-pair-delay 0.1)"
          "(sp-show-pair-from-inside t)"
          "(sp-cancel-autoskip-on-backward-movement nil)"
          "(sp-highlight-pair-overlay nil)"
          "(sp-highlight-wrap-overlay nil)"
          "(sp-highlight-wrap-tag-overlay nil)"
        ];
        diminish = sp-mode;
        hook = "((${cfg.hooks}) . ${sp-mode})";
        config = [
          "(require 'smartparens-config)"
        ];
      };
      rainbow-delimiters = {
        enable = cfg.rainbow-delimiters;
        hook = "(prog-mode . rainbow-delimiters-mode)";
      };
    };
  };
}
