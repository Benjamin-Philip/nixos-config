{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    libgcc
    libclang

    gdb
    lldb

    gnumake
    cmake

    glslang
  ];
}
