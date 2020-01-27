{ trivialBuild, lib, fetchFromGitHub, lsp-mode }:

trivialBuild rec {
  pname = "lsp-latex";
  version = "support-texlab-v1.0";

  src = fetchFromGitHub {
    owner = "ROCKTAKEY";
    repo = "lsp-latex";
    rev = version;
    sha256 = "0k4ps8jcvzp7x8v49ln76qlqrpa6p099w7mazx0hcxjvpw2qg69m";
  };

  dontBuild = true;

  packageRequires = [ lsp-mode ];

  meta = with lib; {
    description = "Language server protocol plugin for texlab";
    license = licenses.gpl3;
    maintainers = with maintainers; [ alexarice ];
  };
}
