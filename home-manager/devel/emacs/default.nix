{ config, lib, pkgs, inputs, ... }:

{
  programs.doom-emacs.enable = true;
  programs.doom-emacs.doomDir = ./doom;

  home.packages = with pkgs; [
    # :core
    symbola
    nerd-fonts.symbols-only

    # :checkers spell
    hunspell

    # :tools docker
    dockfmt
  ];
}
