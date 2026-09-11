{ config, lib, pkgs, ... }:

{
  # TODO: add tests
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
