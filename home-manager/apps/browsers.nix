{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.firefox = {
    enable = true;

    profiles.main = {
      isDefault = true;

      extensions = {
        packages = with pkgs.firefoxAddons; [
          bitwarden-password-manager
          ublock-origin
        ];
      };

      settings = {
        # disable sponsored content
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        # auto enable extensions
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
}
