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

      settings = packageOptions.${name}.settings or (mkOption {
        type = types.unspecified;
        description = ''
          Package specific settings
        '';
      });

      name = mkOption {
        type = types.str;
        default = name;
        description = ''
          Package name to be used from init.el
        '';
      };

      defer = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to defer package loading
        '';
      };

      init = mkOption {
        type = with types; listOf str;
        default = [];
        description = ''
          String to be passed to :init keyword of use-package
        '';
      };

      config = mkOption {
        type = with types; listOf str;
        default = [];
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
        type = with types; either (listOf str) str;
        default = "";
        description = ''
          :magic keyword of use-package
        '';
      };

      magic-fallback = mkOption {
        type = with types; either (listOf str) str;
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
         type = types.str;
         default = "";
         description = ''
           :if keyword of use-package
         '';
      };

      when = mkOption {
         type = types.str;
         default = "";
         description = ''
           :when keyword of use-package
         '';
      };

      unless = mkOption {
         type = types.str;
         default = "";
         description = ''
           :unless keyword of use-package
         '';
      };

      after = mkOption {
         type = types.str;
         default = "";
         description = ''
           :after keyword of use-package
         '';
      };

      defines = mkOption {
         type = with types; either (listOf str) str;
         default = "";
         description = ''
           :defines keyword of use-package
         '';
      };

      functions = mkOption {
         type = with types; either (listOf str) str;
         default = "";
         description = ''
           :functions keyword of use-package
         '';
      };

      diminish = mkOption {
         type = types.str;
         default = "";
         description = ''
           :diminish keyword of use-package
         '';
      };

      delight = mkOption {
         type = types.str;
         default = "";
         description = ''
           :delight keyword of use-package
         '';
      };
    };
  };

  removeNonEmptyLines = s: builtins.concatStringsSep "\n" (builtins.filter (l: l != "") (splitString "\n" s));

  concatLines = s: if builtins.isList s then builtins.concatStringsSep "\n" s else s;

  packageToConfig = p: removeNonEmptyLines ''
    (use-package ${p.name}
    ${if p.defer then ":defer t" else ""}
    ${if p.init != [] then ":init\n${concatLines p.init}" else ""}
    ${if p.config != [] then ":config\n${concatLines p.config}" else ""}
    ${if p.commands != [] then ":commands (${builtins.concatStringsSep " " p.commands})" else ""}
    ${if p.bind != {} then ":bind\n${printBinding (p.bind)}" else ""}
    ${if p.bind-keymap != {} then ":bind-keymap\n${printBinding (p.bind-keymap)}" else ""}
    ${if p.mode != "" then ":mode ${p.mode}" else ""}
    ${if p.interpreter != "" then ":interpreter\n${p.interpreter}" else ""}
    ${if p.magic != "" then ":magic\n${concatLines p.magic}" else ""}
    ${if p.magic-fallback != "" then ":magic-fallback\n${concatLines p.magic-fallback}" else ""}
    ${if p.hook != "" then ":hook\n${p.hook}" else ""}
    ${if p.custom != {} then ":custom\n${printCustom p.custom}" else ""}
    ${if p.custom-face != {} then ":custom-face\n${printCustom p.custom-face}" else ""}
    ${if p.demand then ":demand t" else ""}
    ${if p.if-keyword != "" then ":if\n${p.if-keyword}" else ""}
    ${if p.when != "" then ":when\n${p.when}" else ""}
    ${if p.unless != "" then ":unless\n${p.unless}" else ""}
    ${if p.after != "" then ":after\n${p.after}" else ""}
    ${if p.defines != "" then ":defines\n${concatLines p.defines}" else ""}
    ${if p.functions != "" then ":functions\n${concatLines p.functions}" else ""}
    ${if p.diminish != "" then ":diminish\n${p.diminish}" else ""}
    ${if p.delight != "" then ":delight\n${p.delight}" else ""}
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
    rawPackageList = builtins.concatMap (p: if builtins.isList p.package then p.package else singleton p.package) (filter (p: p.enable) (builtins.attrValues(config.package)));

    externalPackageList = builtins.concatMap (p: p.external-packages) (filter (p: p.enable) (builtins.attrValues (config.package)));

    init-el.packageSetup = builtins.concatStringsSep "\n\n" (map packageToConfig (filter (p: p.enable)(builtins.attrValues (config.package))));
  };
}
