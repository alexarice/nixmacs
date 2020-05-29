{ trivialBuild, lib, fetchFromGitHub, polymode, agda2-mode, markdown-mode }:

trivialBuild rec {
  pname = "org-agda-mode";
  version = "master";

  src = fetchFromGitHub {
    owner = "alexarice";
    repo = "markdown-agda-mode";
    rev = "522bfd0055f959b3dad21cc8b652e3851149852c";
    sha256 = "1fw1cp22ii1iqvls71gs4rq9f91hd46xi67vn022qfs9mwqsvv1r";
  };

  packageRequires = [ polymode agda2-mode markdown-mode ];

  meta = with lib; {
    description = "Clone of org-agda-mode for markdown";
    license = licenses.unfree;
    maintainers = with maintainers; [ alexarice ];
  };
}
