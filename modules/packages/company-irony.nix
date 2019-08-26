{ config, lib, ... }:

with lib;

{
  config.use-package.company-irony = {
    defer = mkDefault true;
  };
}
