{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.qalculate.enable = true;
  programs.qalculate.package = pkgs.qalculate-gtk;
}
