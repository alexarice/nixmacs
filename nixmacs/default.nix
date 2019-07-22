{ stdenv, emacsWithPackages, packageList, initEl, writeText, makeWrapper, runCommand }:

let
  initElDrv = writeText "init-el" initEl;

  emacsPackage = emacsWithPackages (p: packageList);

  pname = "nixmacs";
  version = "0.1.0";
in

runCommand "${pname}-${version}" {
  inherit pname version;
  nativeBuildInputs = [ makeWrapper ];
} ''
  mkdir $out
  makeWrapper ${emacsPackage}/bin/emacs $out/bin/nixmacs \
    --add-flags "-q -l ${initElDrv}"
  ''
