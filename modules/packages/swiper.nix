{ config, lib, ... }:

with lib;

{
  package.swiper.use-package = {
    bind."C-s" = mkDefault "swiper";
  };
}
