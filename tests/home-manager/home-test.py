def directory_exists(dir):
    machine.succeed(f"test -d {dir}")


def program_exists(program):
    machine.succeed(f"su -- ben -c 'which {program}'")


machine.wait_for_unit("default.target")

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
