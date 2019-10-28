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
    keybindings.major-mode.agda2-mode.command = "'hydra-agda/body";
    keybindings.hydra.hydra-agda = {
      docText = "agda";
      bindings = {
        "l" = {
          command = "agda2-load";
          name = "load";
        };
        "f" = {
          command = "agda2-next-goal";
          name = "next goal";
        };
        "b" = {
          command = "agda2-previous-goal";
          name = "previous goal";
        };
        "r" = {
          command = "agda2-refine";
          name = "refine";
        };
        "g" = {
          command = "agda2-give";
          name = "give";
        };
        "c" = {
          command = "agda2-make-case";
          name = "case split";
        };
        "," = {
          command = "agda2-goal-and-context";
          name = "get context";
        };
        "q" = {
          command = "nil";
          name = "cancel";
        };
      };
    };
  };
}
