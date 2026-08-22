{
  pkgs,
  test-machine,
  ...
} @ moduleArgs:
pkgs.testers.runNixOSTest {
  name = "home-test";
  nodes.machine = test-machine;
  testScript = builtins.readFile ./home-test.py;
}
