{
  pkgs,
  inputs,
  ...
}: let
  tests = import ../tests {inherit pkgs inputs;};
  regularChecks = {
    formatting = import ./formatting.nix {inherit pkgs inputs;};
  };
  checks = [tests regularChecks];
in
  pkgs.lib.attrsets.mergeAttrsList checks
