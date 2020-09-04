{ config, lib, ... }:

with lib;

let
  cfg = config.layers.coq;
in
{
  options.layers.coq = {
    enable = mkEnableOption "coq layer";
  };

  config = mkIf cfg.enable {
    package = {
      proof-general.enable = true;
      company-coq.enable = true;
      company.settings.company-hooks."coq-mode" = [
        "company-capf"
        "company-dabbrev-code"
      ];
    };
    keybindings.major-mode.coq-mode.command = "'hydra-coq/body";
    keybindings.hydra.hydra-coq = {
      hint = "nil";
      docText = ''

        _n_: Next Line  _u_: Undo  _b_: Buffer  _r_: Retract  RET: Point  _q_: quit
      '';
      bindings = {
        "n" = "proof-assert-next-command-interactive";
        "u" = "proof-undo-last-successful-command";
        "b" = "proof-process-buffer";
        "r" = "proof-retract-buffer";
        "RET" = "proof-goto-point";
        "q" = {
          command = "nil";
          name = "cancel";
          colour = "blue";
        };
      };
    };
  };
}
