{ lib, ... }:

with lib;

{
  package.ox-publish = {
    package = mkDefault [];
    use-package = {
      commands = mkDefault [
        "org-html-publish-to-html"
        "org-publish-attachment"
      ];
    };
  };
}
