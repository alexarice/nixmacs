{ config, lib, ... }:

with lib;

let
  cfg = config.layers.completion;
in
{

  options.layers.completion = {
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
      description = ''
        Default company backends to be used in every buffer
      '';
    };
  };

  config = {
    package = {
      yasnippet = {
        enable = true;
        use-package = {
          bind."yas-minor-mode-map" =
            if cfg.yas-expand-key == "TAB" then {} else {
              "TAB" = "nil";
              "<tab>" = "nil";
              "${cfg.yas-expand-key}" = "yas-expand";
            };
          custom.yas-snippet-dirs = "${cfg.yas-snippet-dirs}";
        };
      };

      auto-yasnippet = {
        enable = true;
        use-package.bind."${cfg.yas-expand-key}" = "aya-expand";
      };

      company = {
        enable = true;

      };
    };
  };
}
