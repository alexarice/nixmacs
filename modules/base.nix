{ pkgs, config, lib, ... }:

with lib;

{
  options = {
    initEl = mkOption {
      type = types.separatedString "\n\n";
      visible = false;
      readOnly = true;
    };

    finalPackage = mkOption {
      type = types.package;
      visible = false;
      readOnly = true;
    };
  };

  config = {
    finalPackage = pkgs.callPackage ../nixmacs {
      initEl = config.initEl;
      packageList = config.rawPackageList;
    };
  };
}
