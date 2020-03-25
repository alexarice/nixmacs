{ trivialBuild, lib, fetchFromGitHub, polymode, agda2-mode }:

trivialBuild rec {
  pname = "org-agda-mode";
  version = "master";

  src = ./org-agda-mode;

  packageRequires = [ polymode agda2-mode ];

  meta = with lib; {
    description = "An Emacs mode for working with Agda code in an Org-mode like fashion, more or less";
    license = licenses.unfree;
    maintainers = with maintainers; [ alexarice ];
  };
}
