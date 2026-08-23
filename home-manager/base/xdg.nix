{ config, lib, pkgs, ... }:

{
  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
}
