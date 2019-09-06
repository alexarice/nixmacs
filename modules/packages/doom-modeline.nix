{ config, lib, ... }:

with lib;

{
  package.doom-modeline.use-package.config = mkDefault ''
    (doom-modeline-mode 1)
  '';
}
