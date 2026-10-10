{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentry = {
    package = pkgs.pinentry-all;
    program = "pinentry-gnome3";
  };
}
