{
  pkgs,
  test-machine,
  ...
} @ moduleArgs:
pkgs.testers.runNixOSTest {
  name = "configuration-test";
  nodes.machine = test-machine;
  testScript = builtins.readFile ./configuration-test.py;
}
