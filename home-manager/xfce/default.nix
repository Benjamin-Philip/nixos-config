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
}
