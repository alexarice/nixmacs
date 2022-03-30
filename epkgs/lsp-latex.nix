{ trivialBuild, lib, fetchFromGitHub, lsp-mode }:

trivialBuild rec {
  pname = "lsp-latex";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "ROCKTAKEY";
    repo = "lsp-latex";
    rev = "v${version}";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  dontBuild = true;

  packageRequires = [ lsp-mode ];

  meta = with lib; {
    description = "Language server protocol plugin for texlab";
    license = licenses.gpl3;
    maintainers = with maintainers; [ alexarice ];
  };
}
