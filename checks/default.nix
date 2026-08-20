{
  pkgs,
  inputs,
  ...
} @ moduleArgs: let
  tests = import ../tests moduleArgs;
  regularChecks = {
    formatting = import ./formatting.nix moduleArgs;
  };
  checks = [tests regularChecks];
in
  pkgs.lib.attrsets.mergeAttrsList checks
