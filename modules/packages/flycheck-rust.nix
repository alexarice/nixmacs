{ lib, ... }:

with lib;

{
  package.flycheck-rust = {
    use-package = {
      hook = mkDefault "(flycheck-mode . flycheck-rust-setup)";
    };
  };
}
