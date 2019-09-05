{ config, lib, ... }:

with lib;

let
  cfg = config.layers.completion;
in
{
  options.layers.completion = {
    enable = mkEnableOption "completion layer";
  };

  config = mkIf cfg.enable {
    package = {
      yasnippet.enable = mkDefault true;

      auto-yasnippet.enable = mkDefault true;

      company.enable = true;
    };
  };
}
