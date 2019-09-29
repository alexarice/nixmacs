{ lib, pkgs, ... }:

with lib;

{
  package.mu4e = {
    package = mkDefault [];
    use-package.init = mkDefault ''
      (add-to-list 'load-path "${pkgs.mu}/share/site-lisp")
    '';
  };
}
