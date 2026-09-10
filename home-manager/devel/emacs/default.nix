{ config, lib, pkgs, inputs, ... }:

{
  programs.doom-emacs.enable = true;
  programs.doom-emacs.doomDir = ./doom;
}
