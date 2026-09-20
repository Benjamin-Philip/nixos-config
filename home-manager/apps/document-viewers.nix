{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zathura.enable = true;

  # For when I don't feel like dealing with Zathura
  home.packages = [ pkgs.evince ];
}
