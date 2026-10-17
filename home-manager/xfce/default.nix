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

  # bluetooth config
  services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true;

  # stylix wallpaper
  xfconf.settings.xfce4-desktop = {
    "backdrop/screen0/monitoreDP-1/workspace0/image-style" = 5;
    "backdrop/screen0/monitoreDP-1/workspace0/last-image" = "${config.stylix.image}";

    "backdrop/screen0/monitorHDMI-1/workspace0/image-style" = 5;
    "backdrop/screen0/monitorHDMI-1/workspace0/last-image" = "${config.stylix.image}";
  };
}
