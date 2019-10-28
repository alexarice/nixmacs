{ config, lib, ... }:

with lib;

let
  cfg = config.keybindings.hydra;
  hydraType = { name, config, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        default = name;
        example = "hydra-zoom";
        description = ''
          Name of the hydra.
        '';
      };

      docText = mkOption {
        type = with types; nullOr str;
        default = null;
        example = "zoom";
        description = ''
          Description for the hydra.
        '';
      };

      colour = mkOption {
        type = with types; nullOr (enum ["amaranth" "teal" "pink" "red" "blue"]);
        default = null;
        example = "amaranth";
        description = ''
          Hydra body colour.
        '';
      };

      bind = mkOption {
        type = types.str;
        default = "";
        example = ''"global-map \"<f2>\""'';
        description = ''
          Binding to run hydra on.
        '';
      };

      bindings = mkOption {
        type = with types; attrsOf (submodule hydraBind);
        default = {};
        example = {
          "g" = {
            command = "text-scale-increase";
            name = "in";
          };
          "l" = {
            command = "text-scale-decrease";
            name = "out";
          };
        };
        description = ''
          Bindings for this hydra.
        '';
      };

      hydra-text = mkOption {
        type = types.str;
        readOnly = true;
        visible = false;
      };
    };

    config = {
      hydra-text = ''
        (defhydra ${config.name} (${config.bind} ${if config.colour != null then ":color ${config.colour}" else ""})
        "${config.docText}"
        ${concatStringsSep "\n" (map (x: x.command-text) (attrValues config.bindings))}
        )
    '';
    };
  };

  hydraBind = { name, config, ... }: {
    options = {
      keybind = mkOption {
        type = types.str;
        default = name;
        description = ''
          Key to run this command on.
        '';
      };

      command = mkOption {
        type = types.str;
        description = ''
          Command to run.
        '';
      };

      name = mkOption {
        type = types.str;
        description = ''
          Name to display for the command.
        '';
      };

      colour = mkOption {
        type = with types; nullOr (enum ["red" "blue"]);
        default = null;
        description = ''
          Colour for this command.
        '';
      };

      command-text = mkOption {
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };

    config = {
      command-text = ''
        ("${config.keybind}" ${config.command} "${config.name}" ${if config.colour != null then ":color ${config.colour}" else ""})
      '';
    };
  };
in
{
  options = {
    keybindings.hydra = mkOption {
      type = with types; attrsOf (submodule hydraType);
      default = {};
      description = ''
        Attribute set defining hydras.
      '';
    };
  };

  config = mkIf (cfg != {}) {
    package.hydra.enable = true;
    init-el.postSetup = concatStringsSep "\n\n" (map (x: x.hydra-text) (attrValues cfg));
  };
}
