{ config, lib, pkgs, ... }:

{
  # TODO: add tests
  home.packages = with pkgs; [
    html-tidy
    stylelint
    js-beautify
  ];
}
