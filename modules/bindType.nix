{ lib , ... }:

with lib;

let
  assocOption = { name, config, ... }:
  {
    options = {
      name = mkOption {
        type = types.str;
      };
      val = mkOption {
        type = types.str;
      };
    };
  };
  mapOption = { name, config, ... }:
  {
    options = {
      name = mkOption {
        type = types.str;
      };
      bindings = mkOption {
        type = with types; loaOf (submodule assocOption);
      };
    };
  };
  wrapBrackets = x: "(${x})";
in
{
  bindType = with types; loaOf (either (submodule assocOption) (submodule mapOption));

  printBinding = b: wrapBrackets (builtins.concatStringsSep "\n" (flip map b (x:
  if builtins.hasAttr val
  then "(${x.name} . '${x.val})"
  else "(:map ${x.name})\n" ++ builtins.concatStringsSep "\n" (map (y: "(${name} . '${val})") (x.bindings)))));
}
