{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Benjamin Philip";
        email = "benjamin.philip495@gmail.com";
      };

      sendemail = {
        smtpEncryption = "tls";
        smtpServer = "smtp.gmail.com";
        smtpUser = "benjamin.philip495@gmail.com";
        smtpServerPort = 587;
        # TODO: authenticate send-email with sops-nix
      };
      
      github.user = "Benjamin-Philip";

      init.defaultBranch = "main";

      fetch.prune = true;
      fetch.pruneTags = true;
      pull.rebase = true;
      
      push.autoSetupRemote = true;
      push.followTags = true;

      merge.conflictStyle = "zdiff3";
      rere.enabled = true;
      rere.autoUpdate = true;
      
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.navigate = true;

      apply.whitespace = "fix";

      # TODO: setup gpg signing
    };
  };
}
