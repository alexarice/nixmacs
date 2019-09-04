{ config, lib, ... }:

with lib;

let
  cfg = config.layers.completion;
in
{

  options.layers.completion = {
    enable = mkEnableOption "completion layer";
  };

  config = {
    package = {
      yasnippet = {
        enable = true;
      };

      auto-yasnippet = {
        enable = true;
      };

      company = {
        enable = true;
      };
    };
  };
}
