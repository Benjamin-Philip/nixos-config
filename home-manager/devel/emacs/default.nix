{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.doom-emacs.enable = true;
  programs.doom-emacs.emacs = pkgs.emacs-gtk;
  programs.doom-emacs.doomDir = ./doom;
  services.emacs.enable = true;

  home.packages = with pkgs; [
    # :core
    symbola
    nerd-fonts.symbols-only

    # :checkers spell
    (hunspellWithDicts (
      with pkgs.hunspellDicts;
      [
        en_GB-large
        en_US-large
      ]
    ))

    # :tools docker
    dockfmt

    # :app everywhere
    xclip
    xdotool
    xprop
    xwininfo
  ];
}
