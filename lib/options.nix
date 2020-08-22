{ lib }:

with lib;

{
  add-settings = pname: settings: mkOption {
    type = types.submodule {
      options."${pname}".settings = settings;
    };
  };
}
