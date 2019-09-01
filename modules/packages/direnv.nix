{ config, lib, ... }:

with lib;

{
  config.package.direnv.use-package.config = mkDefault "(direnv-mode)";
}
