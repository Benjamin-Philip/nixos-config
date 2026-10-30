{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # TODO: move ollama config here from nixos config
    ./clients.nix
  ];
}
