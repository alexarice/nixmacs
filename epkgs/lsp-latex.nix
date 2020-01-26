{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "lsp-latex";
  version = "support-texlab-v1.0";

  src = fetchFromGitHub {
    owner = "ROCKTAKEY";
    repo = "lsp-latex";
    rev = version;
    sha256 = "0k4ps8jcvzp7x8v49ln76qlqrpa6p099w7mazx0hcxjvpw2qg69m";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/emacs/site-lisp
    cp *.el *.elc $out/share/emacs/site-lisp/
  '';
}
