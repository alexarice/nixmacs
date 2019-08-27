{ config, lib, ... }:

with lib;

{
  config.package.undo-tree = {
    diminish = mkDefault "undo-tree-mode";
    config = mkDefault (singleton "(global-undo-tree-mode 1)")
  };
}
