{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable the fingerprint reader
  services.fprintd.enable = true;

  # Enable CUPS to print documents.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
  programs.system-config-printer.enable = true;

  programs.firefox.enable = true;
}
