{ pkgs, lib, modules, nmdSrc }:

let

  nmd = import nmdSrc { inherit pkgs lib; };

  epkgs = pkgs.emacsPackages;

  packageModule = {
    config._module.args.pkgs = nmd.scrubDerivations "pkgs" pkgs;
    config._module.args.epkgs = nmd.scrubDerivations "epkgs" epkgs;
  };

  moduleDocs = nmd.buildModulesDocs {
    modules = [ packageModule ] ++ modules;
    moduleRootPaths = [ ./.. ];
    mkModuleUrl = path:
      "https://github.com/alexarice/nixmacs/blob/master/${path}#blob-path";
    channelName = "nixmacs";
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
