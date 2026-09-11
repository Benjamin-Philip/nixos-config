{ config, lib, pkgs, ... }:

{
  # TODO: add tests
  home.packages = with pkgs.beam29Packages; [erlang rebar3 ];
}
