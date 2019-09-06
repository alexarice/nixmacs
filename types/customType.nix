{ lib, ... }:

with lib;

let
  inherit (builtins) attrNames getAttr concatStringsSep;
  inherit (import ./lispVarType.nix { inherit lib; }) lispVarType printLispVar;
in
{
  customType = with types; attrsOf lispVarType;

  printCustom = c:
  concatStringsSep "\n" (mapAttrsToList (name: value: "(${name} ${printLispVar value})") c);

  printVariables = c:
    concatStringsSep "\n" (mapAttrsToList (name: value: "(setq ${name} ${printLispVar value})") c);
}
