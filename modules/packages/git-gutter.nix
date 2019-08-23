{ config, lib, ... }:

with lib;

{
  config.use-package.git-gutter = {
    diminish = mkDefault "git-gutter-mode";
    config = mkDefault (singleton "(global-git-gutter-mode 1)");
  };
}
