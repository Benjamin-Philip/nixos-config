{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.nvd ];

  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/Projects/nixos-config";
  };

  # TODO: investigate nh clean rules
}
