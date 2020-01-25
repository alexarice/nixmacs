{ config, lib, ... }:

with lib;

let
  cfg = config.layers.markdown;
in
{
  options.layers.markdown = {
    enable = mkEnableOption "Markdown Layer";
  };

  config = mkIf cfg.enable {
    package = {
      company.settings.company-hooks.markdown-mode = mkDefault [
        "company-files"
        "company-ispell"
        "(company-capf company-dabbrev)"
      ];

      markdown-mode.enable = mkDefault true;
    };
  };
}
