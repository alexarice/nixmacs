{ trivialBuild, lib, fetchFromGitHub, polymode, agda2-mode, markdown-mode }:

trivialBuild rec {
  pname = "org-agda-mode";
  version = "master";

  src = fetchFromGitHub {
    owner = "alexarice";
    repo = "markdown-agda-mode";
    rev = "94fc15678ba54b867e85c82df02c16f5be6e59c3";
    sha256 = "0rky4rjj92xcsypfrd3winv7flkzm4x15bsp6bmrm7xm6gyqzdxr";
  };

  packageRequires = [ polymode agda2-mode markdown-mode ];

  meta = with lib; {
    description = "Clone of org-agda-mode for markdown";
    license = licenses.unfree;
    maintainers = with maintainers; [ alexarice ];
  };
}
