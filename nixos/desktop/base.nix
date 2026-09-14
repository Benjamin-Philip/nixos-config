{ config, lib, pkgs, ... }:

{
  # Enable the fingerprint reader
  services.fprintd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  programs.firefox.enable = true;
}
