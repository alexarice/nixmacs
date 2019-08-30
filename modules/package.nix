{ lib, epkgs, config, packageOptions, ... }:

with lib;

let
  inherit (import ../types/bindType.nix { inherit lib; }) bindType printBinding;
  inherit (import ../types/customType.nix { inherit lib; }) customType printCustom;
  inherit (builtins) hasAttr getAttr;
  packageOpts = { name, config, ... }:
    {
      options = {
        enable = mkEnableOption name;

        package = mkOption {
          type = with types; either package (listOf package);
          default = getAttr name epkgs;
          defaultText = literalExample "epkgs.${name}";
          description = ''
            Nix package for the emacs package
          '';
        };

        external-packages = mkOption {
          type = with types; listOf package;
          default = [];
          description = ''
            Any packages that should be added to emacs' exec-path
          '';
        };

        settings = packageOptions.${name}.settings or (
          mkOption {
            type = types.unspecified;
            description = ''
              Package specific settings
            '';
          }
        );

        name = mkOption {
          type = types.str;
          default = name;
          description = ''
            Package name to be used from init.el
          '';
        };

        use-package = {
          defer = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Whether to defer package loading
            '';
          };

          init = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to :init keyword of use-package
            '';
          };

          config = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to :config keyword of use-package
            '';
          };

          commands = mkOption {
            type = with types; either (listOf str) str;
            default = [];
            description = ''
              List of strings to be passed to :commands keyword of use-package
            '';
          };

          bind = mkOption {
            type = bindType;
            default = {};
            description = ''
              List of bindings to be passed to :bind keyword of use-package
            '';
          };

          bind-keymap = mkOption {
            type = bindType;
            default = {};
            description = ''
              List of bindings to be passed to :bind-keymap keyword of use-package
            '';
          };

          mode = mkOption {
            type = types.str;
            default = "";
            description = ''
              :mode keyword of use-package
            '';
          };

          interpreter = mkOption {
            type = types.str;
            default = "";
            description = ''
              :interpreter keyword of use-package
            '';
          };

          magic = mkOption {
            type = types.lines;
            default = "";
            description = ''
              :magic keyword of use-package
            '';
          };

          magic-fallback = mkOption {
            type = types.lines;
            default = "";
            description = ''
              :magic-fallback keyword of use-package
            '';
          };

          hook = mkOption {
            type = types.str;
            default = "";
            description = ''
              :hook keyword of use-package
            '';
          };

          custom = mkOption {
            type = customType;
            default = {};
            description = ''
              :custom keyword of use-package
            '';
          };

          custom-face = mkOption {
            type = customType;
            default = {};
            description = ''
              :custom-face keyword of use-package
            '';
          };

          demand = mkOption {
            type = types.bool;
            default = false;
            description = ''
              :demand keyword of use-package
            '';
          };

          if-keyword = mkOption {
            type = types.lines;
            default = "";
            description = ''
              :if keyword of use-package
            '';
          };

          when = mkOption {
            type = types.lines;
            default = "";
            description = ''
              :when keyword of use-package
            '';
          };

          unless = mkOption {
            type = types.lines;
            default = "";
            description = ''
              :unless keyword of use-package
            '';
          };

          after = mkOption {
            type = types.lines;
            default = "";
            description = ''
              :after keyword of use-package
            '';
          };

          defines = mkOption {
            type = types.lines;
            default = "";
            description = ''
              :defines keyword of use-package
            '';
          };

          functions = mkOption {
            type = types.lines;
            default = "";
            description = ''
              :functions keyword of use-package
            '';
          };

          diminish = mkOption {
            type = with types; nullOr str;
            default = null;
            description = ''
              :diminish keyword of use-package
            '';
          };

          delight = mkOption {
            type = with types; nullOr str;
            default = null;
            description = ''
              :delight keyword of use-package
            '';
          };
        };
      };
    };

  removeNonEmptyLines = s: builtins.concatStringsSep "\n" (builtins.filter (l: l != "") (splitString "\n" s));

  concatLines = s: if builtins.isList s then builtins.concatStringsSep "\n" s else s;

  packageToConfig = p: let
    up = p.use-package;
  in
    removeNonEmptyLines ''
      (use-package ${p.name}
      ${if up.defer then ":defer t" else ""}
      ${if up.init != "" then ":init\n${up.init}" else ""}
      ${if up.config != "" then ":config\n${up.config}" else ""}
      ${if up.commands != [] then ":commands (${builtins.concatStringsSep " " up.commands})" else ""}
      ${if up.bind != {} then ":bind\n${printBinding (up.bind)}" else ""}
      ${if up.bind-keymap != {} then ":bind-keymap\n${printBinding (up.bind-keymap)}" else ""}
      ${if up.mode != "" then ":mode ${up.mode}" else ""}
      ${if up.interpreter != "" then ":interpreter\n${up.interpreter}" else ""}
      ${if up.magic != "" then ":magic\n${up.magic}" else ""}
      ${if up.magic-fallback != "" then ":magic-fallback\n${up.magic-fallback}" else ""}
      ${if up.hook != "" then ":hook\n${up.hook}" else ""}
      ${if up.custom != {} then ":custom\n${printCustom up.custom}" else ""}
      ${if up.custom-face != {} then ":custom-face\n${printCustom up.custom-face}" else ""}
      ${if up.demand then ":demand t" else ""}
      ${if up.if-keyword != "" then ":if\n${up.if-keyword}" else ""}
      ${if up.when != "" then ":when\n${up.when}" else ""}
      ${if up.unless != "" then ":unless\n${up.unless}" else ""}
      ${if up.after != "" then ":after\n${up.after}" else ""}
      ${if up.defines != "" then ":defines\n${up.defines}" else ""}
      ${if up.functions != "" then ":functions\n${up.functions}" else ""}
      ${if up.diminish != null then ":diminish\n${up.diminish}" else ""}
      ${if up.delight != null then ":delight\n${up.delight}" else ""}
      )
    '';
in
{
  options = {
    package = mkOption {
      default = {};
      type = with types; attrsOf (submodule packageOpts);
      description = ''
        Package setup organised by package name
      '';
    };

    rawPackageList = mkOption {
      type = with types; listOf package;
      visible = false;
    };

    externalPackageList = mkOption {
      type = with types; listOf package;
      visible = false;
    };
  };

  config = {
    rawPackageList = builtins.concatMap (p: if builtins.isList p.package then p.package else singleton p.package) (filter (p: p.enable) (builtins.attrValues (config.package)));

    externalPackageList = builtins.concatMap (p: p.external-packages) (filter (p: p.enable) (builtins.attrValues (config.package)));

    init-el.packageSetup = builtins.concatStringsSep "\n\n" (map packageToConfig (filter (p: p.enable) (builtins.attrValues (config.package))));
  };
}
