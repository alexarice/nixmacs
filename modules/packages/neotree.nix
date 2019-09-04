{ config, lib, ... }:

with lib;

let
  cfg = config.package.neotree.settings;
in
{
  options.package.neotree.settings = {
    neo-theme = mkOption {
      type = types.str;
      default = "arrow";
      description = ''
        Theme for neotree to be passed to <option>neo-theme</option>.
      '';
    };
  };

  config.package.neotree.use-package = {
    custom = {
      neo-smart-open = mkDefault true;
      neo-theme = "'${cfg.neo-theme}";
    };
  };
}
