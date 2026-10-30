{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./ai
    ./core
    ./emacs
    ./lang
  ];
}
