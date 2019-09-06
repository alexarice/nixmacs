{ config, lib, ... }:

with lib;

{
  package.smooth-scrolling = {
    use-package = {
      config = mkDefault "(smooth-scrolling-mode 1)";
      custom = {
        mouse-wheel-scroll-amount = mkDefault "'(1 ((shift) . 1))";
        mouse-wheel-progressive-speed = mkDefault false;
        mouse-wheel-follow-mouse = mkDefault true;
        scroll-step = mkDefault 1;
      };
    };
  };
}
