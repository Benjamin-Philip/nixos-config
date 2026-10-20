{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zotero.enable = true;
  programs.zotero.profiles.default.extensions = with pkgs.zotero-addons; [
    zotero-better-bibtex
  ];
  programs.zotero.profiles.default.settings =
    let
      docPath = "${config.home.homeDirectory}/Documents";
      bibPath = "${docPath}/bibliography.bib";
    in
    {
      # See the config editor at Edit > Settings > Advanced > Config Editor (end of page)
      # See also https://www.zotero.org/support/preferences/hidden_preferences

      "extensions.zotero.dataDir" = "${docPath}/Zotero";

      "extensions.zotero.translators.better-bibtex.autoExport.${lib.strings.escapeURL bibPath}" = {
        "path" = bibPath;
        "translatorID" = "f895aa0d-f28e-47fe-b247-2ea77c6ed583";
        "type" = "library";
        "id" = 1;
        "recursive" = false;
        "enabled" = true;
        "asciiBibLaTeX" = false;
        "biblatexExtendedNameFormat" = true;
        "DOIandURL" = "both";
        "exportNotes" = false;
        "useJournalAbbreviation" = false;
        "biblatexAPA" = false;
        "biblatexChicago" = false;
      };

      # Use the flake-provided versions of plugins, translators and styles.
      "extensions.zotero.automaticScraperUpdates" = false;

      # Item adding settings
      # TODO: enable automatic snapshotting on Zotero 11
      "extensions.zotero.automaticSnapshots" = false; # Take snapshots of webpages when items are made from them
      "extensions.zotero.translators.RIS.import.ignoreUnknown" = false; # Don't discard unknown RIS tags when importing
      "extensions.zotero.translators.attachSupplementary" = true; # "Translators should attempt to attach supplementary data when importing items"

      "extensions.zotero.findPDFs.resolvers" = [
        {
          "name" = "Sci-Hub";
          "method" = "GET";
          "url" = "https://sci-hub.ru/{doi}";
          "mode" = "html";
          "selector" = "#pdf";
          "attribute" = "src";
          "automatic" = true;
        }
        {
          "name" = "Google Scholar";
          "method" = "GET";
          "url" = "{z:openURL}https://scholar.google.com/scholar?q=doi%3A{doi}";
          "mode" = "html";
          "selector" = ".gs_or_ggsm a:first-child";
          "attribute" = "href";
          "automatic" = true;
        }
      ];
    };
}
