{ lib, ... }:

with lib;

{
  package.org-roam-bibtex = {
    use-package = {
      hook = mkDefault "org-roam-mode";
    };
  };
}
