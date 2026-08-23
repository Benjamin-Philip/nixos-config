{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.fish.enable = true;

  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.enableInteractive = true;

  # "Modern" CLI tools

  home.packages = [pkgs.duf pkgs.dust pkgs.hyperfine pkgs.ouch pkgs.sd pkgs.viddy];
  programs.bat.enable = true;
  programs.delta.enable = true;

  programs.eza.enable = true;
  programs.eza.enableFishIntegration = true;
  programs.eza.icons = "auto";

  programs.fd.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;

  programs.ripgrep.enable = true;

  programs.tealdeer.enable = true;
  programs.tealdeer.settings.updates.auto_update = true;

  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;
}
