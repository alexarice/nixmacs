{ config, lib, ... }:

with lib;

{
  config.package.company-irony = {
    defer = mkDefault true;
  };
}
