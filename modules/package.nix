{ lib, epkgs, config, packageOptions, ... }:

with lib;

let
  packageOpts = { name, config, ... }:
    {
      options = {
        enable = mkEnableOption name;

        package = mkOption {
          type = with types; either package (listOf package);
          default = getAttr name epkgs;
          defaultText = literalExample "epkgs.${name}";
          description = ''
            Nix package to install that provides ${name}. Can also be a list of packages to be installed, for example to include an optional dependency.
          '';
        };

        external-packages = mkOption {
          type = with types; listOf package;
          default = [];
          example = literalExample "[ pkgs.ag ]";
          description = ''
            Packages that should be added to nixmacs' path.
          '';
        };

        priority = mkOption {
          type = types.int;
          default = 1000;
          example = 500;
          description = ''
            How early in the <filename>init.el</filename> the use-package declaration should appear.
          '';
        };

        settings = packageOptions.${name}.settings or (
          mkOption {
            type = types.unspecified;
            description = ''
              Package specific settings. See <link linkend="package-options">Package Options</link> section for available options.
            '';
          }
        );

        name = mkOption {
          type = types.str;
          default = name;
          description = ''
            Package name to be used within <filename>init.el</filename>.
          '';
        };

        use-package = {
          text = mkOption {
            type = types.str;
            description = ''
              Package initialisation text.
            '';
          };

          defer = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Boolean to be passed to the <option>:defer</option> keyword of use-package.
            '';
          };

          init = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:init</option> keyword of use-package.
            '';
          };

          config = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:config</option> keyword of use-package.
            '';
          };

          commands = mkOption {
            type = with types; either (listOf str) str;
            default = [];
            description = ''
              List of strings to be passed to <option>:commands</option> keyword of use-package.
            '';
          };

          bind = mkOption {
            type = types.bindType;
            default = {};
            #TODO better description
            description = ''
              Attribute set of bindings to be passed to <option>:bind</option> keyword of use-package.
            '';
          };

          bind-keymap = mkOption {
            type = types.bindType;
            default = {};
            description = ''
              List of bindings to be passed to <option>:bind-keymap</option> keyword of use-package.
            '';
          };

          mode = mkOption {
            type = types.str;
            default = "";
            description = ''
              String to be passed to the <option>:mode</option> keyword of use-package.
            '';
          };

          interpreter = mkOption {
            type = types.str;
            default = "";
            description = ''
              String to be passed to the <option>:interpreter</option> keyword of use-package.
            '';
          };

          magic = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:magic</option> keyword of use-package.
            '';
          };

          magic-fallback = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:magic-fallback</option> keyword of use-package.
            '';
          };

          hook = mkOption {
            type = types.str;
            default = "";
            description = ''
              String to be passed to the <option>:hook</option> keyword of use-package.
            '';
          };

          custom = mkOption {
            type = types.varBindType;
            default = {};
            description = ''
              Attribute set to be passed to the <option>:custom</option> keyword of use-package.
            '';
          };

          custom-face = mkOption {
            type = types.varBindType;
            default = {};
            description = ''
              Attribute set to be passed to the <option>:custom-face</option> keyword of use-package.
            '';
          };

          demand = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Boolean to be passed to the <option>:demand</option> keyword of use-package.
            '';
          };

          if-keyword = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:if</option> keyword of use-package.
            '';
          };

          when = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:when</option> keyword of use-package.
            '';
          };

          unless = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:unless</option> keyword of use-package.
            '';
          };

          after = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:after</option> keyword of use-package.
            '';
          };

          defines = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:defines</option> keyword of use-package.
            '';
          };

          functions = mkOption {
            type = types.lines;
            default = "";
            description = ''
              String to be passed to the <option>:functions</option> keyword of use-package.
            '';
          };

          diminish = mkOption {
            type = with types; nullOr str;
            default = null;
            description = ''
              String to be passed to the <option>:diminish</option> keyword of use-package.
            '';
          };

          delight = mkOption {
            type = with types; nullOr str;
            default = null;
            description = ''
              String to be passed to the <option>:delight</option> keyword of use-package.
            '';
          };

          chords = mkOption {
            type = types.bindType;
            default = {};
            description = ''
              Attribute set to be passed to the <option>:chords</option> keyword of use-package.
            '';
          };
        };
      };
      config = {
        use-package.text = mkDefault (packageToConfig config);
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
      ${if up.chords != {} then ":chords\n${printBinding up.chords}" else ""}
      )
    '';

  comparator = fst: snd: fst.priority < snd.priority || (fst.priority == snd.priority && fst.name < snd.name);
in
{
  options = {
    package = mkOption {
      default = {};
      type = with types; attrsOf (submodule packageOpts);
      description = ''
        Package setup organised by package name.
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

    init-el.packageSetup = builtins.concatStringsSep "\n\n" (map (x: x.use-package.text) (filter (p: p.enable) (builtins.sort comparator (builtins.attrValues (config.package)))));
  };
}
