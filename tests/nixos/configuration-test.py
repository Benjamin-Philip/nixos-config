machine.wait_for_unit("default.target")

with subtest("hostname set as rivendell"):
    (status, stdout) = machine.execute("hostname")
    t.assertEqual(status, 0, msg="hostname does not exist!")
    t.assertEqual(stdout, "rivendell\n", msg="Invalid hostname!")

with subtest("user ben has been correctly created"):
    (status, stdout) = machine.execute("id ben")
    t.assertEqual(status, 0, msg="User ben has not been created!")
    t.assertRegex(stdout, r"groups=.*wheel")

with subtest("home-manager-ben.service is active"):
    machine.require_unit_state("home-manager-ben.service", "active")

with subtest("OpenSSH server is active"):
    machine.require_unit_state("sshd.service", "active")
