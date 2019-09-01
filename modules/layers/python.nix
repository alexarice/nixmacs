{ config, lib, ... }:

with lib;

let
  cfg = config.layers.python;
in
{
  options.layers.python.enable = mkEnableOption "python layer";

  config = mkIf cfg.enable {
    package = {
      anaconda-mode.enable = true;
      anaconda-eldoc-mode.enable = true;
      company-anaconda.enable = config.package.company.enable;
    };

    layers.completion.company-hooks.python-mode-hook = [ "company-anaconda" "company-dabbrev-code" ];
  };
}
