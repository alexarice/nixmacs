{ config, lib, ... }:

with lib;

{
  config.package.neotree = {
    custom = {
      neo-smart-open = mkDefault true;
    };
  };
}
