{
  config,
  lib,
  pkgs,
  ...
}:

{
  # TODO: test email

  programs.notmuch.enable = true;
  services.lieer.enable = true;

  accounts.email.accounts.personal = {
    enable = true;
    realName = "Benjamin Philip";
    address = "benjamin.philip495@gmail.com";
    userName = "benjamin.philip495@gmail.com";
    flavor = "gmail.com";
    primary = true;

    notmuch.enable = true;

    lieer.enable = true;

    # make deletes driven by gmail's trash system,
    # giving us robust retention
    lieer.settings.local_trash_tag = "deleted";
    lieer.settings.remove_local_messages = true;

    # don't ignore gmail categories
    lieer.settings.ignore_remote_labels = [ ];

    lieer.sync.enable = true;
    lieer.sync.frequency = "minutely";
  };

  # use gmail's unread status
  programs.notmuch.new.tags = [ "inbox" ];
}
