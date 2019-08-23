{ config, lib, ... }:

with lib;

{
  config.use-package.rainbow-delimiters = {
    hook = mkDefault "(prog-mode . rainbow-delimiters-mode)";
  };
}
