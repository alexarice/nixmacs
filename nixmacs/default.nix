{ emacsPackage, initEl, externalPackageList, writeText, makeWrapper, runCommand, substituteAll, lib, runtimeShell, docs }:

let
  binpath = lib.makeBinPath externalPackageList;
  initElDrv = (writeText "init.el" initEl);

  emacsExecutable = "${emacsPackage}/bin/emacs";

  pname = "nixmacs";
  version = "0.1.0";
in

runCommand "${pname}-${version}" {
  inherit pname version;
  nativeBuildInputs = [ makeWrapper ];
} ''
  install -D ${initElDrv} $out/init.el
  ${emacsExecutable} -batch -f batch-byte-compile $out/init.el
  install -D ${docs.json}/* -t $out/share/doc
  cp -r ${docs.html}/* $out
  cp -r ${docs.manPages}/* $out
  makeWrapper ${runtimeShell} $out/shell \
    ${if binpath != "" then "--prefix PATH : ${binpath}" else ""}
  makeWrapper ${emacsExecutable} $out/bin/nixmacs \
    --add-flags "-q -l $out/init.elc" \
    --set INITEL $out/init.el \
    ${if binpath != "" then "--prefix PATH : ${binpath}" else ""} \
    --set SHELL $out/shell
''
