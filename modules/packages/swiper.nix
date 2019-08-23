{ config, lib, ... }:

with lib;

{
  config.use-package.swiper = {
    bind."C-s" = mkDefault "swiper";
  };
}
