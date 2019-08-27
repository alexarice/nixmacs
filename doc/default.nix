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
    docBook.id = "nixmacs-options";
  };

  docs = nmd.buildDocBookDocs {
    pathName = "nixmacs";
    modulesDocs = [ moduleDocs ];
    documentsDirectory = ./.;
    chunkToc = ''
      <toc>
        <d:tocentry xmlns:d="http://docbook.org/ns/docbook" linkend="book-nixmacs-manual"><?dbhtml filename="index.html"?>
          <d:tocentry linkend="ch-options"><?dbhtml filename="options.html"?></d:tocentry>
        </d:tocentry>
      </toc>
    '';
  };

in
{
  json = moduleDocs.json;
  inherit (docs) manPages html;
}
