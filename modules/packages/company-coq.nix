{ config, lib, ... }:

with lib;

{
  package.company-coq.use-package = {
    hook = mkDefault "(coq-mode . company-coq-mode)";
  };
}
