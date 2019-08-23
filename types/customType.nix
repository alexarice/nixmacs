{ lib, ... }:

with lib;

let
  inherit (builtins) attrNames getAttr concatStringsSep;
  inherit (import ./lispVarType.nix { inherit lib; }) lispVarType printLispVar;
in
{
  customType = with types; attrsOf lispVarType;

  printCustom = c:
  let
    items = attrNames c;
  in
  concatStringsSep "\n" (map (item: "(${item} ${printLispVar (getAttr item c)})") items);
}
