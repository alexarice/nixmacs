{ config, lib, ... }:

with lib;

{
  config.package.git-gutter = {
    diminish = mkDefault "git-gutter-mode";
    config = mkDefault "(global-git-gutter-mode 1)";
  };
}
