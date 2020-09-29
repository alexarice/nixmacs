{ pkgs, configurationFile, package ? pkgs.emacs }:

let
  lib = pkgs.callPackage ./lib { };
  modules = import ./modules/modules.nix { };
  overrides = import ./epkgs/overrides.nix { inherit pkgs; };
  nmdSrc = pkgs.fetchFromGitLab {
    owner = "rycee";
    repo = "nmd";
    rev = "b437898c2b137c39d9c5f9a1cf62ec630f14d9fc";
    sha256 = "18j1nh53cfpjpdiwn99x9kqpvr0s7hwngyc0a93xf4sg88ww93lq";
  };
  docs = pkgs.callPackage ./doc {
    inherit lib modules nmdSrc;
  };

in import ./nixmacs.nix {
  inherit pkgs configurationFile modules overrides package lib docs;
}
