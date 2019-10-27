{ config, lib, ... }:

with lib;

{
  package.agda2-mode = {
    use-package = {
      mode = mkDefault ''"\\.l?agda\\'"'';
      init = mkIf (config.package.which-key.enable) (mkDefault ''
        (add-hook 'agda2-mode-hook '(lambda () (which-key-mode 0)) :local)
      ''); # which-key and agda2 don't seem to play nice
    };
  };
}
