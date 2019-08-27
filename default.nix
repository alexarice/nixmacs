{ pkgs, lib, configurationFile }:

with lib;

let
  modules = import ./modules/modules.nix { inherit pkgs lib; };
  emacsPackage = (pkgs.emacsWithPackages (epkgs:
  let
    cleanseOptions = f: { config, lib, epkgs, pkgs, ... }@args:
    let
      oldModule = f args;
    in
    {
      inherit (oldModule) config;
      options = removeAttrs (oldModule.options or {}) [ "package" ];
    };
    cleanseConfig = f: args:
    let
      oldModule = f args;
    in
    {
      inherit (oldModule) options;
    };
    pkgsModule = {
      config._module.args.pkgs = pkgs;
      config._module.args.epkgs = epkgs;
    };
    preEval = evalModules {
      modules = [ pkgsModule ] ++  modules.packageModules;
    };
    optionsModule = {
      config._module.args.packageOptions = preEval.options.package;
    };
    evaledModule = evalModules {
      modules = [ configurationFile pkgsModule optionsModule ] ++ modules.baseModules ++ map cleanseOptions modules.packageModules;
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
