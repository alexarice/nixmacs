{ lib, ... }:

with lib;

{
  package.dante = {
    use-package = {
      after = mkDefault [ "haskell-mode" ];
      commands = mkDefault [ "dante-mode" ];
      hook = mkDefault "(haskell-mode . dante-mode)";
    };
  };
}
