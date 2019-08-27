{ pkgs, lib, configurationFile }:

with lib;

let
  modules = import ./modules/modules.nix { inherit pkgs lib; };
  emacsPackage = (pkgs.emacsWithPackages (epkgs:
    let
      pkgsModule = {
        config._module.args.pkgs = lib.mkDefault pkgs;
        config._module.args.epkgs = epkgs;
      };
      evaledModule = evalModules {
        modules = [ configurationFile pkgsModule ] ++ modules;
      };
    in {
      inherit (evaledModule.config) rawPackageList initEl externalPackageList;
    })).overrideAttrs (oldAttrs:
    let
      oldReqs = oldAttrs.explicitRequires;
      explicitRequires = oldReqs.rawPackageList;
    in {
      inherit explicitRequires;
      inherit (oldReqs) initEl externalPackageList;
      deps = oldAttrs.deps.overrideAttrs (o: { inherit explicitRequires; });
    });
in
pkgs.callPackage ./nixmacs {
  inherit emacsPackage;
  inherit (emacsPackage) initEl externalPackageList;
}
