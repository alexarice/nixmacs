{ config, lib, ... }:

with lib;

{
  config.package.flycheck.config = mkDefault "(global-flycheck-mode)";
}
