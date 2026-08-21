{
  pkgs,
  lib,
  ...
} @ moduleArgs: let
  test-machine = {
    imports = [(import ../nixos/common.nix moduleArgs)];
  };
  args = moduleArgs // {inherit test-machine;};
  nixosTests = import ./nixos args;
  hmTests = import ./home-manager args;
  leafTests = {};
  tests = [nixosTests hmTests leafTests];
in
  pkgs.lib.attrsets.mergeAttrsList tests
