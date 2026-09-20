{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager

    ./desktop
  ];

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";

      allowed-users = [
        "@wheel"
        "@nix-home-manager-users"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
    # Opinionated: disable channels
    channel.enable = false;
  };

  networking.hostName = "rivendell"; # Define your hostname.
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  services.automatic-timezoned.enable = true;
  time.timeZone = null;

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    ben = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      description = "Benjamin Philip";
      initialPassword = "nixos";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [
        "wheel"
        "networkmanager"
      ];

      shell = pkgs.fish;
    };
  };

  programs.fish.enable = true;
  environment.shells = [
    pkgs.bash
    pkgs.fish
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Import your home-manager configuration
      ben = import ../home-manager/home.nix;
    };

    enableLegacyProfileManagement = false;
    useUserPackages = true;
    backupFileExtension = "bak";
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.05";
}
