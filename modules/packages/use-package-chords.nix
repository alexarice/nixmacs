{ config, lib, ... }:

with lib;

{
  package.use-package-chords = {
    use-package = {
      config = mkDefault ''
        (key-chord-mode 1)
      '';
      custom.key-chord-two-keys-delay = mkDefault 0.2;
    };
    priority = mkDefault 500;
  };
}
