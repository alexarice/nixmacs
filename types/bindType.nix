{ lib , ... }:

with lib;

let
  inherit (builtins) concatStringsSep attrNames isString getAttr sort;
  mapOption = { name, config, ... }:
  {
    options = {
      bindings = mkOption {
        type = with types; loaOf str;
      };
    };
  };
  wrapBrackets = x: "(${x})";
in
{
  bindType = with types; loaOf (either str (submodule mapOption));

  printBinding = b:
  let
    items = attrNames b;
    sortedItems = sort (x: y: isString x && !(isString y)) items;
  in wrapBrackets (concatStringsSep "\n" (flip map (sortedItems) (x:
  let item = getAttr x b;
  in if isString item
  then "(\"${x}\" . ${item})"
  else ":map ${x.name})\n" ++ concatStringsSep "\n" (map (y: "(\"${y}\" . ${getAttr y item})") (attrNames (x.bindings))))));
}
