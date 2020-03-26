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
      org-agda-mode.enable = mkIf config.layers.org.enable true;
      company.settings.company-hooks."agda2-mode" = [
        "company-capf"
        "company-dabbrev-code"
      ];
    };
    keybindings.major-mode.agda2-mode.command = "'hydra-agda/body";
    keybindings.hydra.hydra-agda = {
      hint = "nil";
      docText = ''

        _l_: Load         _f_: Next goal      _r_: Refine  _g_: Give       _s_: Solve
        _,_: Get context  _b_: Previous goal  _a_: Auto    _c_: Case split
      '';
      bindings = {
        "l" = "agda2-load";
        "f" = "agda2-next-goal";
        "b" = "agda2-previous-goal";
        "r" = "agda2-refine";
        "g" = "agda2-give";
        "c" = "agda2-make-case";
        "," = "agda2-goal-and-context";
        "a" = "agda2-auto-maybe-all";
        "s" = "agda2-solve-maybe-all";
        "q" = {
          command = "nil";
          name = "cancel";
          colour = "blue";
        };
      };
    };
  };
}
