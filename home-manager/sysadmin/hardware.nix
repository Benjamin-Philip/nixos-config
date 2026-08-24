{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Bus & Peripheral Enumeration
    pciutils
    usbutils
    i2c-tools

    # System Architecture, Topology & DMI
    lshw
    dmidecode
    hwloc      # Provides lstopo, lstopo-no-graphics
    cpuid

    # Thermals & Power
    lm_sensors
    powertop
    tlp

    # Display & Graphics Capability Inspection
    edid-decode
    clinfo
    vulkan-tools
  ];
}
