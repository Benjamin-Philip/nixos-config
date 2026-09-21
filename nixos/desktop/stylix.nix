{
  config,
  lib,
  pkgs,
  ...
}:

let
  image = pkgs.fetchurl {
    url = "https://www.nhm.ac.uk/resources/visit/wpy/2018/large/webp/8.webp";
    hash = "sha256-5vCbpIIxh3hpGBX1HNapbDWz7o1zFO2p9kPnbuDeHdk=";
  };
in
{
  stylix = {
    enable = true;
    autoEnable = true;

    image =
      pkgs.runCommand "wallpaper.png"
        {
          nativeBuildInputs = [ pkgs.imagemagick ];
        }
        ''
          magick ${image} $out
        '';

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  };
}
