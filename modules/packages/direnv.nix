{ config, lib, ... }:

with lib;

{
  package.direnv.use-package.config = mkDefault "(direnv-mode)";
}
