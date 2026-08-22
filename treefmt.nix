{ pkgs, ... }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";
  programs.black.enable = true;
}
