{ config, lib, ... }:

with lib;

{
  package.use-package-chords = {
    use-package = {
      config = mkDefault ''
        (key-chord-mode 1)
      '';
    };
    priority = mkDefault 500;
  };
}
