{ config, lib, ... }:

with lib;

{
  package.python.use-package = {
    custom = {
      python-indent-guess-indent-offset-verbose = false;
    };
  };
}
