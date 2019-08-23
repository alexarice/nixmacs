{ lib }:

with lib;

let
  inherit (builtins) isInt isFloat isString;
in
{
  lispVarType = with types; nullOr (either int (either float (either bool str)));

  printLispVar = v:
  if v == null then "nil" else if isInt v || isFloat v || isString v then toString v else if v then "t" else "nil";
}
