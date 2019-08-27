{ config, lib, ... }:

with lib;

{
  config.package.swiper = {
    bind."C-s" = mkDefault "swiper";
  };
}
