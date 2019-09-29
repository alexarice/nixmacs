{ lib, ... }:

with lib;

{
  package.rjsx-mode = {
    use-package = {
      mode = ''"components\\/.*\\.js\\'"'';
    };
  };
}
