{ pkgs, lib, package, modules, overrides, configurationFile, docs, extraOverrides }:

with lib;
let
  emacsPackages = let
    epkgs = pkgs.emacsPackagesFor package;
  in (epkgs.overrideScope' overrides).overrideScope' extraOverrides;
  emacsPackage = (
    emacsPackages.emacsWithPackages (
      epkgs:
        let
          pkgsModule = {
            config._module.args.pkgs = pkgs;
            config._module.args.epkgs = epkgs;
            config._module.check = true;
          };

          evaledModule = evalModules {
            modules = [ configurationFile pkgsModule ] ++ modules;
          };
        in
          {
            inherit (evaledModule.config) rawPackageList initEl externalPackageList;
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
            inherit (oldReqs) initEl externalPackageList;
          };
          deps = oldAttrs.deps.overrideAttrs (o: { inherit explicitRequires; });
        }
  );
in
pkgs.callPackage ./nixmacs {
  inherit emacsPackage docs;
  inherit (emacsPackage.passthru) initEl externalPackageList;
}
