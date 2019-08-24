{ emacsPackage , initEl, externalPackageList, writeText, makeWrapper, runCommand, substituteAll, lib, runtimeShell}:

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
  mkdir -p $out
  makeWrapper ${runtimeShell} $out/shell \
    --prefix PATH : ${binpath}
  makeWrapper ${emacsPackage}/bin/emacs $out/bin/nixmacs \
    --add-flags "-q -l ${initElDrv}" \
    --set INITEL ${initElDrv} \
    --prefix PATH : ${binpath} \
    --set SHELL $out/shell
  ''
