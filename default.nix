{ pkgs, package ? pkgs.emacs, configurationFile }:


let
  lib = pkgs.callPackage ./lib {};
in
with lib;
let
  modules = import ./modules/modules.nix { };
  overrides = import ./epkgs/overrides.nix { inherit pkgs; };
  emacsPackages = let
    epkgs = pkgs.emacsPackagesNgGen package;
  in epkgs.overrideScope' overrides;
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

          cleanseConfig = f: { config, lib, epkgs, pkgs, ... }@args:
            let
              oldModule = f args;
            in if oldModule ? options then
            {
              inherit (oldModule) options;
            } else {};

          pkgsModule = {
            config._module.args.pkgs = pkgs;
            config._module.args.epkgs = epkgs;
            config._module.check = true;
          };

          cleansedPackageModules = map cleanseConfig modules.packageModules;

          preEval = evalModules {
            modules = cleansedPackageModules ++ [ pkgsModule ];
          };

          optionsModule = {
            config._module.args.packageOptions = preEval.options.package;
          };

          cleansedModules = modules.baseModules ++ map cleanseOptions modules.packageModules;

          evaledModule = evalModules {
            modules = [ configurationFile ] ++ cleansedModules ++ [ optionsModule pkgsModule ];
          };
        in
          {
            inherit (evaledModule.config) rawPackageList initEl externalPackageList;
            docs = import ./doc {
              inherit epkgs pkgs lib;
              packageModules = cleansedPackageModules;
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
