{ pkgs, lib, modules }:

let

  nmdSrc = pkgs.fetchFromGitLab {
    owner = "rycee";
    repo = "nmd";
    rev = "ddfb3861fd8aa7c59fc68e912f178270b13a672e";
    sha256 = "02p136j10hj8q5qyp2y83qryk8zql7kwxcf23wzdlcskfv1b4ih2";
  };

  nmd = import nmdSrc { inherit pkgs; };

  moduleDocs = nmd.buildModulesDocs {
    inherit modules;
    moduleRootPaths = [ ./.. ];
    mkModuleUrl = path:
      "https://github.com/alexarice/nixmacs/blob/master/${path}#blob-path";
    channelName = "whatGoesHere";
    docBook.id = "whatGoesHere2";
  };

in
moduleDocs.json
