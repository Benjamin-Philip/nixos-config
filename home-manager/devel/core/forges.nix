{ config, lib, pkgs, ... }:

{
  # TODO: authenticate gh with sops-nix
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "";
    };
    hosts = {
      "github.com" = {
        user = "Benjamin-Philip";
        git_protocol = "ssh";          
      };
    };
  };
}
