{ config, lib, ... }:

with lib;

{
  config.package.undo-tree.use-package = {
    diminish = mkDefault "undo-tree-mode";
    config = mkDefault "(global-undo-tree-mode 1)";
  };
}
