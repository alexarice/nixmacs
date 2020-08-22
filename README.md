# nixmacs
Emacs distribution using the nix module system

See option documentation at https://alexarice.github.io/nixmacs/

## Installation

The easiest way to install is by an overlay where you can use a variety of options to get the source:

```nix
self: super: {
  nixmacs = let
    src-option-1 = fetchFromGitHub {
      owner = "alexarice";
      repo = "nixmacs";
      rev = "...";
      sha256 = "...";
    };
    src-option-2 = /path/to/local/checkout;
    # If you set a channel "nixmacs https://github.com/alexarice/nixmacs/archive/master.tar.gz"
    src-option-3 = <nixmacs>;
    src-option-4 = builtins.fetchTarball { url = "https://github.com/alexarice/nixmacs/archive/master.tar.gz"; };
  in self.pkgs.callPackage src-option-1 {
    configurationFile = /path/to/nixmacs-conf.nix;
  };
}
```

There are some examples of config files in the `example` folder.

You will need to be on nixpkgs unstable or pass a nixpkgs unstable package set in with
```
self.pkgs.callPackage src {
  configurationFile = ...;
  pkgs = <nixpkgs-unstable>.pkgs;
}
```
