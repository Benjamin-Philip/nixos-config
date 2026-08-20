{
  pkgs,
  lib,
  ...
} @ moduleArgs: let
  test-machine = {
    imports = [(import ../nixos/common.nix moduleArgs)];
  };
  nixosTests = import ./nixos (moduleArgs // {inherit test-machine;});
  leafTests = {};
  tests = [nixosTests leafTests];
in
  pkgs.lib.attrsets.mergeAttrsList tests
