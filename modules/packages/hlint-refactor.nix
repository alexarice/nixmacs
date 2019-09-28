{ config, lib, pkgs, ... }:

with lib;

{
  package.hlint-refactor = {
    external-packages = with pkgs.haskellPackages; mkDefault [ hlint apply-refact ];
    use-package = {
      init = mkIf config.package.dante.enable (mkDefault ''
        (add-hook 'dante-mode-hook
          '(lambda () (flycheck-add-next-checker 'haskell-dante
                       '(warning . haskell-hlint))))
      '');
    };
  };
}
