{ lib, ... }:

with lib;

let
  inherit (builtins) attrNames getAttr concatStringsSep;
in
{
  customType = with types; attrsOf str;

  printCustom = c:
  let
    items = attrNames c;
  in
  concatStringsSep "\n" (map (item: "(${item} ${getAttr item c})") items);
}
