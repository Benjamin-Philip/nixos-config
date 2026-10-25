{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./cc.nix
    ./elixir.nix
    ./erlang.nix
    ./latex.nix
    ./markdown.nix
    ./nix.nix
    ./org.nix
    ./python.nix
    ./racket.nix
    ./rust.nix
    ./sh.nix
    ./web.nix
  ];
}
