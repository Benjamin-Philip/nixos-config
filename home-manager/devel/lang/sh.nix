{ config, lib, pkgs, ... }:

{
  # TODO: add tests
  home.packages = with pkgs; [
    shfmt
    shellcheck
  ];
}
