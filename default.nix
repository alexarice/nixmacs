{ pkgs, lib, configurationFile }:

with lib;

let
  modules = import ./modules/modules.nix { inherit pkgs lib; };
  pkgsModule =
  {
    config._module.args.pkgs = lib.mkDefault pkgs;
  };
in
(evalModules { modules = ([ configurationFile pkgsModule ] ++ modules); }).config.finalPackage
