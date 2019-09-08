{ pkgs, lib, finalModules, packageModules, epkgs }:

let

  nmdSrc = pkgs.fetchFromGitLab {
    owner = "rycee";
    repo = "nmd";
    rev = "b437898c2b137c39d9c5f9a1cf62ec630f14d9fc";
    sha256 = "18j1nh53cfpjpdiwn99x9kqpvr0s7hwngyc0a93xf4sg88ww93lq";
  };

  nmd = import nmdSrc { inherit pkgs lib; };

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
    modules = [ packageModule ] ++ finalModules;
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
