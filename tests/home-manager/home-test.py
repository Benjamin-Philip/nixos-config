def directory_exists(dir):
    machine.succeed(f"test -d {dir}")


def file_exists(file):
    machine.succeed(f"test -f {file}")


def program_exists(program):
    machine.succeed(f"su -- ben -c 'which {program}'")


machine.wait_for_unit("default.target")


##############
# Base Tests #
##############

with subtest("XDG correctly enabled"):
    directory_exists("/home/ben")
    directory_exists("/home/ben/Documents")
    directory_exists("/home/ben/.config")
    directory_exists("/home/ben/.local")

with subtest("shell configuration"):
    program_exists("fish")
    (status, default_shell) = machine.execute("su -- ben -c 'echo $SHELL'")
    t.assertIn("fish", default_shell)

    program_exists("starship")

    modern_cli_tools = [
        "duf",
        "dust",
        "hyperfine",
        "ouch",
        "sd",
        "viddy",
        "bat",
        "delta",
        "eza",
        "fd",
        "fzf",
        "rg",
        "tldr",
        "zoxide",
    ]
    for tool in modern_cli_tools:
        program_exists(tool)

###############
# Devel Tests #
###############

# Core

with subtest("git correctly enabled"):
    program_exists("git")
    file_exists("/home/ben/.config/git/config")

with subtest("gh correctly enabled"):
    program_exists("gh")
    file_exists("/home/ben/.config/gh/config.yml")
    file_exists("/home/ben/.config/gh/hosts.yml")

# Emacs

with subtest("doom emacs correctly enabled"):
    program_exists("emacs")
    program_exists("doom")
    # TODO: rewrite to ignore some warnings
    # machine.succeed(
    #     "su -- ben <<< \"doom doctor | grep -Pvqz 'There (are|is) \d+ (warning|error)(s)?\!'\""
    # )


##################
# SysAdmin Tests #
##################

with subtest("hardware tools"):
    hardware_tools = [
        "lspci",
        "lsusb",
        "i2cdump",
        "lshw",
        "dmidecode",
        "hwloc-info",
        "cpuid",
        "sensors",
        "powertop",
        "tlp",
        "edid-decode",
        "clinfo",
        "vulkaninfo",
    ]
    for tool in hardware_tools:
        program_exists(tool)

with subtest("networking tools"):
    networking_tools = [
        "gping",
        "mtr",
        "doggo",
        "dig",
        "nslookup",
        "nmap",
        "rustscan",
        "httpie",
        "curlie",
        "xh",
        "nc",
        "socat",
        "trip",
    ]
    for tool in networking_tools:
        program_exists(tool)

    # trippy test
    trippy_config = "/home/ben/.config/trippy/trippy.toml"
    file_exists(trippy_config)
    machine.succeed(
        f"$(su -- ben -c 'which trip') -c {trippy_config} -m json -C 5 localhost"
    )

with subtest("monitoring tools"):
    monitoring_tools = [
        "procs",
        "gdu",
        "ncdu",
        "iotop",
        "bandwhich",
        "nvtop",
        "btop",
        "htop",
    ]
    for tool in monitoring_tools:
        program_exists(tool)

with subtest("nix helpers"):
    program_exists("nh")
    program_exists("nvd")

with subtest("processes tools"):
    processes_tools = [
        "pstree",
        "fuser",
        "killall",
        "lsof",
        "strace",
        "ltrace",
        "bpftrace",
    ]
    for tool in processes_tools:
        program_exists(tool)

with subtest("storage tools"):
    storage_tools = [
        "nvme",
        "smartctl",
        "gdisk",
        "sgdisk",
        "cgdisk",
        "parted",
        "btrfs",
        "fatlabel",
        "mke2fs",
        "ntfslabel",
        "xfs_copy",
        "ddrescue",
        "nwipe",
        "testdisk",
        "borg",
        "rclone",
        "restic",
        "rsync",
        "syncthing",
    ]
    for tool in storage_tools:
        program_exists(tool)
