{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    texlive.combined.scheme-full
    texlab
  ];

  fonts.fontconfig.enable = true;
}
