{ lib , ... }:

with lib;

let
  inherit (builtins) concatStringsSep attrNames isString getAttr sort;

  wrapBrackets = x: "(${x})";
in
{
  bindType = with types; loaOf (either str (loaOf str));

  printBinding = b:
  let
    items = attrNames b;
    sortedItems = sort (x: y: isString x && !(isString y)) items;
  in wrapBrackets (concatStringsSep "\n" (flip map (sortedItems) (x:
  let item = getAttr x b;
  in if isString item
  then "(\"${x}\" . ${item})"
  else ":map ${x}\n${concatStringsSep "\n" (map (y: ''
    "${y}" . ${getAttr y item})
  '') (attrNames item))}")));
}
