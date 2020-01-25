{ config, lib, ... }:

with lib;

let
  cfg = config.keybindings.major-mode;
  bindOptions = { config, name, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        default = name;
        description = ''
          Key for this keybinding.
        '';
      };

      binds = mkOption {
        type = with types; nullOr (attrsOf str);
        default = {};
        example = {
            r = "nix-repl";
        };
        description = ''
          Key bindings to be set for given major mode. Implementation is up to keybinding system.
        '';
      };

      command = mkOption {
        type = types.str;
        default = "leader-${name}-sub-map";
        description = ''
          Command to run for the major mode key. Default activates <code>leader-${name}-sub-map</code>.
        '';
      };
    };
  };
in
{
  options = {
    keybindings = {
      major-mode = mkOption {
        type = with types; attrsOf (submodule bindOptions);
        description = ''
          Key bindings for major modes.
        '';
      };
    };
  };
}
