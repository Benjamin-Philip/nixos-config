{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Disk Health
    nvme-cli
    smartmontools

    # Disk Partitioning
    gptfdisk
    parted

    # Filesystem Maintenance
    # TODO: Move these to the Nix Configuration
    btrfs-progs
    dosfstools
    e2fsprogs
    hfsprogs
    ntfs3g
    xfsprogs

    # Data Recovery & Wiping
    ddrescue
    nwipe
    testdisk

    # Backup, Mirroring & Cloud Sync
    borgbackup
    restic
    rsync
    syncthing
  ];

  # TODO: Investigate rclone mounting for Google Drive
  programs.rclone.enable = true;

  # TODO: Investigate backup strategies
}
