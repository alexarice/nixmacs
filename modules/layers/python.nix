{ config, lib, ... }:

with lib;

let
  cfg = config.layers.python;
in
{
  options.layers.python.enable = mkEnableOption "python layer";

  config = mkIf cfg.enable {
    package = {
      anaconda-mode.enable = mkDefault true;
      anaconda-eldoc-mode.enable = mkDefault true;
      company-anaconda.enable = mkDefault config.package.company.enable;
      company.settings.company-hooks.python-mode = mkDefault [
        "company-anaconda"
        "company-dabbrev-code"
      ];
    };
  };
}
