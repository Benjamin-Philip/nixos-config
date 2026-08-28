{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    # Visual Probes & Latency
    gping
    mtr

    # DNS Utilities
    doggo
    bind.dnsutils # dig, nslookup

    # Port Scanning & Discovery
    nmap
    rustscan

    # HTTP & API Testing
    httpie
    curlie
    xh

    # Low-Level Sockets & Bandwidth Testing
    netcat
    socat
  ];

  # TODO: Configure trippy
  programs.trippy.enable = true;
  programs.trippy.settings.bindings.toggle-help = "h";
}
