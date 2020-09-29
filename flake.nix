{
  description = "Nixmacs: a nix based emacs distribution";

  inputs.nmd = {
    url = gitlab:rycee/nmd;
    flake = false;
  };

  outputs = { self, nixpkgs, nmd }:
  let pkgs = import nixpkgs { system = "x86_64-linux"; };
      lib = pkgs.callPackage ./lib { };
      modules = import ./modules/modules.nix { };
      overrides = import ./epkgs/overrides.nix { inherit pkgs; };
  in {
    docs = pkgs.callPackage ./doc {
      inherit lib modules;
      nmdSrc = nmd;
    };

    nixmacs = { configurationFile, package }:
      pkgs.callPackage ./nixmacs.nix {
        inherit configurationFile package lib modules overrides;
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
