{ config, lib, pkgs, ... }:

{
  imports = [
    ./forges.nix
    ./vcs.nix
  ];
}
