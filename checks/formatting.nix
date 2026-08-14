{
  pkgs,
  inputs,
  ...
}:
pkgs.runCommand "check-formatting"
{buildInputs = [pkgs.alejandra];}
''
  alejandra --check ${inputs.self}
  touch $out
''
