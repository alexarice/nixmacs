{ trivialBuild, lib, fetchFromGitHub, polymode, agda2-mode }:

trivialBuild rec {
  pname = "org-agda-mode";
  version = "master";

  src = fetchFromGitHub {
    owner = "alexarice";
    repo = "org-agda-mode";
    rev = "fe0a1561cf34e3273b58bd1b742f66f1268434b4";
    sha256 = "0c3cbm5djr5g733zgvf6pnkvvadsmg8dcy4b6gh458khgag9r82w";
  };

  packageRequires = [ polymode agda2-mode ];

  meta = with lib; {
    description = "An Emacs mode for working with Agda code in an Org-mode like fashion, more or less";
    license = licenses.unfree;
    maintainers = with maintainers; [ alexarice ];
  };
}
