{ config, lib, ... }:

with lib;

{
  package.agda2-mode = {
    use-package = {
      mode = mkDefault ''"\\.l?agda\\'"'';
      config = mkIf (config.package.which-key.enable) (mkDefault ''
        (which-key-mode)
      ''); # which-key and agda2 don't seem to play nice
    };
  };
}
