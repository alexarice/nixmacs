{ emacsPackage , initEl, writeText, makeWrapper, runCommand }:

let
  initElDrv = writeText "init-el" initEl;

  pname = "nixmacs";
  version = "0.1.0";
in

runCommand "${pname}-${version}" {
  inherit pname version;
  nativeBuildInputs = [ makeWrapper ];
} ''
  mkdir $out
  cp ${initElDrv} $out
  makeWrapper ${emacsPackage}/bin/emacs $out/bin/nixmacs \
    --add-flags "-q -l ${initElDrv}"
  ''
