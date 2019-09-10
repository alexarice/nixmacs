{ lib, ... }:

with lib;
{
  package.diminish.priority = mkDefault 400;
}
