{ pkgs, ... }: {
  home.packages = with pkgs; [
    # State Tracking & History
    psmisc # pstree, fuser, killall

    # File Handles & Namespaces
    lsof

    # System Call Tracing & Debugging
    strace
    ltrace
    bpftrace
  ];
}
