{ lib, ... }:

with lib;

{
  package.mu4e-overview.use-package.after = singleton "mu4e";
}
