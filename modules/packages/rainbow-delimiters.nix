{ config, lib, ... }:

with lib;

{
  package.rainbow-delimiters.use-package = {
    hook = mkDefault "(prog-mode . rainbow-delimiters-mode)";
  };
}
