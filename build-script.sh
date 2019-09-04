#! /bin/sh

nix-build build.nix
mkdir build
cp -r result/share/doc/nixmacs/* build
chmod -R +rw build
