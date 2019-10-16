{ config, lib, ... }:

with lib;

let
  cfg = config.layers.agda;
in
{
  options.layers.agda = {
    enable = mkEnableOption "agda layer";
  };

  config = mkIf cfg.enable {
    package = {
      agda2-mode.enable = true;
      company.settings.company-hooks."agda2-mode" = [
        "company-capf"
        "company-dabbrev-code"
      ];
    };
    keybindings.major-mode.agda2-mode = {
      "l" = "agda2-load";
    };
  };
}
