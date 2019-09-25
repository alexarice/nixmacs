{ config, lib, ... }:

with lib;

let
  cfg = config.package.which-key.settings;
  setup-string = i: "(which-key-setup-${location i})";
  location = i: if i == "minibuffer" then i else "side-window-${i}";
in
{
  options.package.which-key.settings = {
    setup = mkOption {
      type = with types; nullOr (enum [
        "bottom"
        "right"
        "right-bottom"
        "minibuffer"
      ]);
      default = "bottom";
      example = null;
      description = ''
        Activate which-key default config.
      '';
    };
  };

  config.package.which-key = {
    use-package = {
      config = mkDefault ''
        ${if cfg.setup != null then setup-string cfg.setup else ""}
        (which-key-mode)
      '';
      custom.which-key-show-transient-maps = mkDefault true;
    };
  };
}
