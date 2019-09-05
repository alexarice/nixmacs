{ pkgs, package ? pkgs.emacs, lib, configurationFile }:

with lib;

let
  modules = import ./modules/modules.nix { inherit pkgs lib; };
  emacsPackages = pkgs.emacsPackagesNgGen package;
  emacsPackage = (
    emacsPackages.emacsWithPackages (
      epkgs:
        let
          cleanseOptions = f: { config, lib, epkgs, pkgs, ... }@args:
            let
              oldModule = f args;
            in
              if oldModule ? config then
                {
                  inherit (oldModule) config;
                  options = removeAttrs (oldModule.options or {}) [ "package" ];
                } else oldModule;

          pkgsModule = {
            config._module.args.pkgs = pkgs;
            config._module.args.epkgs = epkgs;
          };

          checkModule = {
            config._module.check = true;
          };

          preEval = evalModules {
            modules = [ pkgsModule checkModule ] ++ modules.packageModules;
          };

          optionsModule = {
            config._module.args.packageOptions = preEval.options.package;
          };

          cleansedModules = modules.baseModules ++ map cleanseOptions modules.packageModules;

          evaledModule = evalModules {
            modules = [ configurationFile pkgsModule optionsModule checkModule ] ++ cleansedModules;
          };
        in
          {
            inherit (evaledModule.config) rawPackageList initEl externalPackageList;
            docs = import ./doc {
              inherit pkgs lib epkgs;
              inherit (modules) packageModules;
              finalModules = [ optionsModule ] ++ cleansedModules;
            };
          }
    )
  ).overrideAttrs (
    oldAttrs:
      let
        oldReqs = oldAttrs.explicitRequires;
        explicitRequires = oldReqs.rawPackageList;
      in
        {
          inherit explicitRequires;
          passthru = {
            inherit (oldReqs) initEl externalPackageList docs;
          };
          deps = oldAttrs.deps.overrideAttrs (o: { inherit explicitRequires; });
        }
  );
in
pkgs.callPackage ./nixmacs {
  inherit emacsPackage;
  inherit (emacsPackage.passthru) initEl externalPackageList docs;
}
