{ config, lib, ... }:

with lib;

{
  config.package.company.use-package = {
    custom = {
      company-idle-delay = mkDefault 0.1;
      company-minimum-prefix-length = mkDefault 2;
      company-seletcion-wrap-around = mkDefault true;
    };
    diminish = "company-mode";
  };
}
