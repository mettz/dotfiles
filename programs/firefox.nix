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
      settings = {};
    };
  };
}
