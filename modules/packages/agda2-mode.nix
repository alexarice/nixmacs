{ lib, ... }:

with lib;

{
  package.agda2-mode = {
    use-package = {
      defer = true;
    };
  };
}
