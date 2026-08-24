{ config, lib, pkgs, ... }:

{
  home.packages = [pkgs.nvd];

  programs.nh.enable = true;

  # TODO: investigate nh clean rules
}
