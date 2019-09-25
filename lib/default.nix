{ lib, fetchFromGitHub }:

lib.extend (lib: oldLib:
let
  yantsSrc = fetchFromGitHub {
    owner = "alexarice";
    repo = "yants";
    rev = "9cfb3f2fe94153091b37cd81816c5aea4413f2e4";
    sha256 = "1cgbl6lsxsz7hx73wikb5lbh90np8wfnahqz5wx5h3di31fw1m75";
  };
  inherit (builtins) functionArgs intersectAttrs;
  callLib = file:
  let
    f = import file;
    args = functionArgs f;
  in f (intersectAttrs args { inherit oldLib lib; });
in
rec {
  printers = callLib ./printers.nix;
  types = oldLib.types // (callLib ./types.nix);
  yants = (callLib "${yantsSrc}/default.nix") // (callLib ./yants.nix);
  inherit (printers) printLispVar printCustom printVariables printBinding printGeneral;
})
