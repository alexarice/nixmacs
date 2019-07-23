{ config, lib, ... }:

with lib;

{
  options.init-el = {
    preamble = mkOption {
      type = types.separatedString "\n\n";
      default = "";
      description = ''
        Items to be put at the top of init.el. Should not rely on any package.
      '';
    };

    packageSetup = mkOption {
      type = types.str;
      visible = false;
      readOnly = true;
      description = ''
        init.el fragment for setting up packages using use-package
      '';
    };

    postSetup = mkOption {
      type = types.separatedString "\n\n";
      default = "";
      description = ''
        Items to be put after package initialisation
      '';
    };
  };

  config = {
    initEl = ''
      ;; Preamble
      ${config.init-el.preamble}

      ;; Packages
      ${config.init-el.packageSetup}

      ;; Post package initialisation
      ${config.init-el.postSetup}
    '';
  };
}
