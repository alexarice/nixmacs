{ lib, ... }:

with lib;

{
  package.toml-mode = {
    use-package = {
      mode = mkDefault ''"/\\(Cargo.lock\\|\\.cargo/config\\)\\'"'';
    };
  };
}
