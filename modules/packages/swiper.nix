{ config, lib, ... }:

with lib;

{
  config.package.swiper.use-package = {
    bind."C-s" = mkDefault "swiper";
  };
}
