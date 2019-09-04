{ config, lib, ... }:

with lib;

{
  options.init-el = {
    preamble = mkOption {
      type = types.separatedString "\n\n";
      default = "";
      description = ''
        Items to be put at the top of <filename>init.el</filename>. Should not rely on any package.
      '';
    };

    packageSetup = mkOption {
      type = types.str;
      visible = false;
      readOnly = true;
    };

    postSetup = mkOption {
      type = types.separatedString "\n\n";
      default = "";
      description = ''
        Text to be put after package initialisation in <filename>init.el</filename>.
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
