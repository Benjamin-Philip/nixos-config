# tests/default.nix
{
  pkgs,
  inputs,
  ...
}: let
  childTest = {};
  leafTests = {};
  tests = [childTest leafTests];
in
  pkgs.lib.attrsets.mergeAttrsList tests
