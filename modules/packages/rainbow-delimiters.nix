{ config, lib, ... }:

with lib;

{
  config.package.rainbow-delimiters = {
    hook = mkDefault "(prog-mode . rainbow-delimiters-mode)";
  };
}
