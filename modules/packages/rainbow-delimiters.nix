{ config, lib, ... }:

with lib;

{
  config.package.rainbow-delimiters.use-package = {
    hook = mkDefault "(prog-mode . rainbow-delimiters-mode)";
  };
}
