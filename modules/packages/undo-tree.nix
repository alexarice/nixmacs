{ config, lib, ... }:

with lib;

{
  package.undo-tree.use-package = {
    diminish = mkDefault "undo-tree-mode";
    config = mkDefault "(global-undo-tree-mode 1)";
  };
}
