{ config, lib, ... }:

with lib;

{
  config.package.flycheck.use-package.config = mkDefault "(global-flycheck-mode)";
}
