{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./audio.nix
    ./base.nix
    ./display-server.nix
    ./stylix.nix
  ];
}
