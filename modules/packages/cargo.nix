{ lib, ... }:

with lib;

{
  package.cargo = {
    use-package = {
      hook = mkDefault "(rust-mode . cargo-minor-mode)";
    };
  };
}
