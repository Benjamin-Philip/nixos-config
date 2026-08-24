{ config, lib, pkgs, ... }:{
  home.packages = with pkgs; [
    # Process Inspection
    procs

    # Storage & Disk Usage
    gdu
    ncdu

    # I/O, Network & GPU Monitoring
    iotop
    bandwhich
    nvtopPackages.full # GPU monitoring (NVIDIA/AMD/Intel)
  ];

  programs.btop.enable = true;
  programs.htop.enable = true;
}
