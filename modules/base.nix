{ lib, ... }:

with lib;

{
  options = {
    initEl = mkOption {
      type = types.separatedString "\n\n";
      visible = false;
      readOnly = true;
    };
  };
}
