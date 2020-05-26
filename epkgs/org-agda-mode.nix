{ trivialBuild, lib, fetchFromGitHub, polymode, agda2-mode }:

trivialBuild rec {
  pname = "org-agda-mode";
  version = "master";

  src = fetchFromGitHub {
    owner = "alhassy";
    repo = "org-agda-mode";
    rev = "9422f79e4ecdb10118f7c73b86b8f01e7aa0df14";
    sha256 = "18alpbilgjglib2pvn2cykw44c2bzgbj1zx63rn6kdszmx3hz56s";
  };

  packageRequires = [ polymode agda2-mode ];

  meta = with lib; {
    description = "An Emacs mode for working with Agda code in an Org-mode like fashion, more or less";
    license = licenses.unfree;
    maintainers = with maintainers; [ alexarice ];
  };
}
