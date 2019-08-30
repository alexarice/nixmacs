{ emacsPackage, initEl, externalPackageList, writeText, makeWrapper, runCommand, substituteAll, lib, runtimeShell, docs }:

let
  binpath = lib.makeBinPath externalPackageList;
  initElDrv = (writeText "init.el" initEl);

  pname = "nixmacs";
  version = "0.1.0";
in

runCommand "${pname}-${version}" {
  inherit pname version;
  nativeBuildInputs = [ makeWrapper ];
} ''
  mkdir -p $out/share/doc
  cp ${initElDrv} $out/init.el
  cp -r ${docs.json}/* $out/share/doc
  cp -r ${docs.html}/* $out
  cp -r ${docs.manPages}/* $out
  makeWrapper ${runtimeShell} $out/shell \
    --prefix PATH : ${binpath}
  makeWrapper ${emacsPackage.outPath}/bin/emacs $out/bin/nixmacs \
    --add-flags "-q -l $out/init.el" \
    --set INITEL $out/init.el \
    --prefix PATH : ${binpath} \
    --set SHELL $out/shell
''
