{ lib, ... }:

with lib;

{
  package.rjsx-mode = {
    use-package = {
      mode = mkDefault ''"\\.js\\'"'';
      config = mkDefault ''
        (add-hook 'rjsx-mode-hook (setq-local indent-line-function 'js-jsx-indent-line))
      '';
    };
  };
}
