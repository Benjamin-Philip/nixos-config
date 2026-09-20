{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./browsers.nix
    ./calculator.nix
    ./document-viewers.nix
    ./office-suite.nix
    ./photoshop.nix
  ];
}
