{ lib }:

with lib;
with lib.yants;

{
  switchType = struct "switch" { type = type; action = any; };
  switch = x: l: if l == [] then throw "switch statement did not match" else let y = builtins.head l; in if (switchType y).type.check x then y.action else switch x (builtins.tail l);

  case = t: a: { type = t; action = a; };
}
