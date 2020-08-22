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
            docs = import ./doc {
              inherit epkgs pkgs lib;
              finalModules = modules;
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
