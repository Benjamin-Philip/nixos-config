{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./monitoring.nix
    ./networking.nix
    ./nix-helpers.nix
    ./processes.nix
    ./storage.nix
  ];
}
