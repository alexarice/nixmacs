{ config, lib, ... }:

with lib;

{
  package.git-gutter.use-package = {
    diminish = mkDefault "git-gutter-mode";
    config = mkDefault "(global-git-gutter-mode 1)";
  };
}
