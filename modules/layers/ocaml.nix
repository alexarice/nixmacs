{ config, lib, ... }:

with lib;

let
  cfg = config.layers.ocaml;
in
{
  options.layers.ocaml.enable = mkEnableOption "ocaml layer";

  config = mkIf cfg.enable {
    package = {
      tuareg.enable = mkDefault true;
      merlin.enable = mkDefault true;
      company.settings.company-hooks.caml-mode = mkDefault [
        "(company-capf company-dabbrev-code)"
      ];
    };
  };
}
