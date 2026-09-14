def program_exists(program):
    machine.succeed(f"which {program}")


def unit_exists(unit):
    machine.succeed(f"systemctl list-unit-files {unit}")


machine.wait_for_unit("default.target")

with subtest("hostname set as rivendell"):
    (status, stdout) = machine.execute("hostname")
    t.assertEqual(status, 0, msg="hostname does not exist!")
    t.assertEqual(stdout, "rivendell\n", msg="Invalid hostname!")

with subtest("networking enabled"):
    machine.require_unit_state("NetworkManager.service", "active")
    # TODO: test if wireless is enabled

with subtest("time zone set"):
    from datetime import datetime

    machine.require_unit_state("automatic-timezoned.service", "active")
    (_status, stdout) = machine.execute("date +%H:%M")
    now = datetime.now().strftime("%H:%M")
    t.assertEqual(stdout.strip("\n"), now)

with subtest("user ben has been correctly created"):
    (status, stdout) = machine.execute("id ben")
    t.assertEqual(status, 0, msg="User ben has not been created!")
    t.assertRegex(stdout, r"groups=.*wheel")

with subtest("home-manager-ben.service is active"):
    machine.require_unit_state("home-manager-ben.service", "active")

with subtest("OpenSSH server is active"):
    machine.require_unit_state("sshd.service", "active")


###########
# Desktop #
###########

with subtest("audio"):
    # TODO: write more robust tests
    program_exists("pw-cli")

with subtest("base"):
    # TODO: check if fprintd is enabled in D-Bus
    unit_exists("cups.service")

with subtest("display-server"):
    machine.require_unit_state("display-manager.service", "active")
    # TODO: test if xfce is enabled
