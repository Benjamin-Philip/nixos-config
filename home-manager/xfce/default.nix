{
  config,
  lib,
  pkgs,
  ...
}:

{
  # TODO: test if symlink has been correctly set

  xdg.configFile."xfce4".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/nixos-config/home-manager/xfce/xfce4";

  # panel plugins
  home.packages = with pkgs; [
    xfce4-whiskermenu-plugin
    xfce4-weather-plugin
    xfce4-pulseaudio-plugin
  ];
}
