{ config, lib, pkgs, ... }:

{
  # TODO: add tests
  programs.direnv.enable = true;
  home.packages = with pkgs; [nixfmt]; 
}
