{ trivialBuild, lib, fetchFromGitHub, polymode, agda2-mode, auctex }:

trivialBuild rec {
  pname = "org-agda-mode";
  version = "master";

  src = fetchFromGitHub {
    owner = "alexarice";
    repo = "literate-agda-mode";
    rev = "0247d74f1a48782e869f1f8854fb7e1b9d9d8334";
    sha256 = "y/pF0Pn7LrU7c7te1YkMnC2HbCZRCNLhoqPUXeK9hCo=";
  };

  packageRequires = [ polymode agda2-mode auctex ];

  meta = with lib; {
    description = "Clone of org-agda-mode for latex";
    license = licenses.unfree;
    maintainers = with maintainers; [ alexarice ];
  };
}
