{ config, lib, pkgs, ... }:

with lib;

{
  package.protobuf-mode.use-package = {
    defer = true;
  };
}
