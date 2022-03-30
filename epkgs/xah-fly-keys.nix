{ trivialBuild, lib, fetchFromGitHub }:

trivialBuild rec {
  pname = "xah-fly-keys";
  version = "master";

  src = fetchFromGitHub {
    owner = "xahlee";
    repo = "xah-fly-keys";
    rev = "79cd23a24d3a5f400d1c3f39a6f220d257772783";
    sha256 = "sha256-pq3MpH9896o3EVteCtIL8bpQdJWi/24CerMOXJZOw7I=";
  };

  dontBuild = true;

  packageRequires = [ ];

  meta = with lib; {
    description = "A modal keybinding for emacs (like vim), but based on command frequency and ergonomics";
    license = licenses.gpl3;
    maintainers = with maintainers; [ alexarice ];
  };
}
