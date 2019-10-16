{ lib, ... }:

with lib;

{
  package.agda2-mode = {
    use-package = {
      mode = ''"\\.l?agda\\'"'';
    };
  };
}
