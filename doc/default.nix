{ pkgs, lib, finalModules, packageModules, epkgs }:

let

  nmdSrc = pkgs.fetchFromGitLab {
    owner = "rycee";
    repo = "nmd";
    rev = "9751ca5ef6eb2ef27470010208d4c0a20e89443d";
    sha256 = "0rbx10n8kk0bvp1nl5c8q79lz1w0p1b8103asbvwps3gmqd070hi";
  };

  nmd = import nmdSrc { inherit pkgs; };

  packageModule = {
    config._module.args.pkgs = nmd.scrubDerivations "pkgs" pkgs;
    config._module.args.epkgs = nmd.scrubDerivations "epkgs" epkgs;
  };

  packageDocs = nmd.buildModulesDocs {
    modules = [ packageModule ] ++ packageModules;
    moduleRootPaths = [ ./.. ];
    mkModuleUrl = path: "https://github.com/alexarice/nixmacs/blob/master/${path}#blob-path";
    channelName = "nixmacs";
    docBook.id = "nixmacs-package-options";
  };

  moduleDocs = nmd.buildModulesDocs {
    modules = finalModules;
    moduleRootPaths = [ ./.. ];
    mkModuleUrl = path:
      "https://github.com/alexarice/nixmacs/blob/master/${path}#blob-path";
    channelName = "nixmacs";
    docBook.id = "nixmacs-options";
  };

  docs = nmd.buildDocBookDocs {
    pathName = "nixmacs";
    modulesDocs = [ moduleDocs packageDocs ];
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
