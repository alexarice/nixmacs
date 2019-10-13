{ lib, ... }:

with lib;

{
  package.rust-mode = {
    use-package = {
      defer = mkDefault true;
    };
  };
}
