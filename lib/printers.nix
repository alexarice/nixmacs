{ lib }:

with lib;

let
  wrapBrackets = x: "(${x})";
  inherit (builtins) isInt isFloat isString;
in
{
  # Print a lispVarType to a string that lisp can recognise
  printLispVar = v:
    (if v == null then "nil" else if isInt v || isFloat v || isString v then toString v else if v then "t" else "nil");

  # Print a varBindType to the format for the :custom keyword
  printCustom = c:
    concatStringsSep "\n" (mapAttrsToList (name: value: "(${name} ${printLispVar value})") c);

  # Print a varBindType to a list of (setq x y)
  printVariables = c:
    concatStringsSep "\n" (mapAttrsToList (name: value: "(setq ${name} ${printLispVar value})") c);

  # Print a bindType to the format for the :bind keyword
  printBinding = b:
    let
      items = attrNames b;
      sortedItems = sort (x: y: isString x && !(isString y)) items;
    in
      wrapBrackets (
        concatStringsSep "\n" (
          flip map (sortedItems) (
            x:
              let
                item = getAttr x b;
              in
                if isString item
                then "(\"${x}\" . ${item})"
                else ":map ${x}\n${concatStringsSep "\n" (
                  map (
                    y: ''
                      ("${y}" . ${getAttr y item})
                    ''
                  ) (attrNames item)
                )}"
          )
        )
      );

  printGeneral = {
    keymaps ? "",
    predicate ? "",
    prefix ? "",
    binds
  }: let
    bindList = extractBinds "" binds;
    extractBinds = prefix: b: with yants; switch b [
      (case string [{ key = prefix; command = b; }])
      (case types.nameValue [{ key = prefix; command = b._value; wk = b._name; }])
      (case types.nameBinds ((optional (b ? _name) { key = prefix; wk = b._name; }) ++ (foldr concat [] (mapAttrsToList (name: value: extractBinds (prefix + name) value) (removeAttrs b [ "_name" ])))))
    ];
    printBind = b: "  " + ''"${b.key}" ${if b ? wk then "'(${if b ? command then b.command else ":ignore t" } :which-key \"${b.wk}\")" else "'" + b.command}'';
  in ''
    (general-define-key
      ${if keymaps != "" then ":keymaps '" + keymaps else ""}
      ${if prefix != "" then ":prefix \"${prefix}\"" else ""}
      ${if predicate != "" then ":predicate " + predicate else ""}
    ${concatStringsSep "\n" (map printBind bindList)}
    )
  '';
}
