{ config, lib, ... }:

with lib;

{
  config.use-package.neotree = {
    custom = {
      neo-smart-open = mkDefault true;
    };
  };
}
