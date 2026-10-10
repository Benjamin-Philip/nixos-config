{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./gpg.nix
    ./shell.nix
    ./xdg.nix
  ];
}
