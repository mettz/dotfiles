{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    profiles.dev-edition-default = {
      id = 0;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
        vimium
        keepa
      ];
      search = {
        default = "DuckDuckGo";
        force = true;
      };
      # here you can list firefox settings, e.g.:
      # {
      #   "browser.startup.homepage" = "https://nixos.org";
      #   "browser.search.region" = "GB";
      #   "browser.search.isUS" = false;
      #   "browser.newtabpage.pinned" = [{
      #     title = "NixOS";
      #     url = "https://nixos.org";
      #   }];
      # }
      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.newtabpage.pinned" = [ ];
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
        "browser.newtabpage.activity-stream.feeds.section.highlights" = true;
        "browser.search.suggest.enabled.private" = true;
        "browser.sessionstore.max_resumed_crashes" = 0;
        "extensions.pocket.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "identity.fxaccounts.toolbar.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "signon.autofillForms" = false;
        "signon.rememberSignons" = false;
        "ui.key.menuAccessKeyFocuses" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };
}
