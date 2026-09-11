{ config, lib, pkgs, ... }:

{
  imports = [
    ./core
    ./emacs
    ./lang
  ];
}
