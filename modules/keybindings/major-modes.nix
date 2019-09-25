{ config, lib, ... }:

with lib;

let
  cfg = config.keybindings.major-mode;
in
{
  options = {
    keybindings = {
      major-mode = mkOption {
        type = with types; attrsOf (attrsOf str);
        default = {};
        example = {
          nix-mode = {
            r = "nix-repl";
          };
        };
        description = ''
          Key bindings to be set for given major mode. Implementation is up to keybinding system.
        '';
      };
    };
  };
}
