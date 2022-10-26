{ trivialBuild, lib, fetchFromGitHub, polymode, agda2-mode, auctex }:

trivialBuild rec {
  pname = "literate-agda-mode";
  version = "master";

  src = fetchFromGitHub {
    owner = "alexarice";
    repo = "literate-agda-mode";
    rev = "7b7a194c18cb33d8eb6d04fd6e04186ff5dea235";
    sha256 = "sha256-gVcuGvdZ98CBdfdLcAlpVhyKp28CXyw74YIAjHykSQ0=";
  };

  packageRequires = [ polymode agda2-mode auctex ];

  meta = with lib; {
    description = "Clone of org-agda-mode for latex";
    license = licenses.unfree;
    maintainers = with maintainers; [ alexarice ];
  };
}
