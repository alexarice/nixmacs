{ config, lib, ... }:

with lib;

{
  config.package.flycheck.config = mkDefault (singleton "(global-flycheck-mode)");
}
