{ config, lib, pkgs, ... }:

{
  # TODO: add tests
  programs.uv.enable = true;
  programs.uv.settings.python.versions = ["3.14"];

  # packages required by emacs
  home.packages = [pkgs.pipenv];
  programs.uv.settings.tool.packages = ["black" "nosetests" "pytest"];
}
