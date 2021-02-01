{
  description = "Nixmacs: a nix based emacs distribution";

  inputs = {
    nmd = {
      url = gitlab:rycee/nmd;
      flake = false;
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { self, nixpkgs, nmd, emacs-overlay }:
  let pkgs = import nixpkgs {
    system = "x86_64-linux";
    config = { allowUnfree = true; };
    overlays = [ emacs-overlay.overlay ];
  };
  lib = pkgs.callPackage ./lib { };
  modules = import ./modules/modules.nix { };
  overrides = import ./epkgs/overrides.nix { inherit pkgs; };
  in {
    docs = pkgs.callPackage ./doc {
      inherit lib modules;
      nmdSrc = nmd;
    };

    nixmacs = { configurationFile, package, extraOverrides ? (self: super: {}) }:
      pkgs.callPackage ./nixmacs.nix {
        inherit configurationFile package lib modules overrides extraOverrides;
        inherit (self) docs;
      };

    fromConf = configurationFile: self.nixmacs {
      inherit configurationFile;
      package = pkgs.emacs;
    };

    example = self.fromConf ./example/config.nix;
    minimal = self.fromConf ./example/minimal.nix;

    defaultPackage.x86_64-linux = self.example;
  };
}
