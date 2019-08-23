{ config, lib, ... }:

with lib;

{
  config.use-package.flycheck.config = mkDefault (singleton "(global-flycheck-mode)");
}
