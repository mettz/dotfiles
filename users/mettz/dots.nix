{ config, pkgs, inputs, system, ... }:

{
  imports = [
    ../../dots/fish
  ];

  home.username = "mettz";
  home.homeDirectory = "/home/mettz";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    dua
    fd

    # networking tools
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    neofetch
    file
    which
    tree

    # productivity
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    lm_sensors # for `sensors` command
    pciutils # lspci
    usbutils # lsusb
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Mattia Guazzaloca";
    userEmail = "me@mettz.dev";
  };


  nixpkgs.overlays = [ inputs.nur.overlay ];

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

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  #programs.alacritty = {
  #  enable = true;
  #  # custom settings
  #  settings = {
  #    env.TERM = "xterm-256color";
  #    font = {
  #      size = 12;
  #      draw_bold_text_with_bright_colors = true;
  #    };
  #    scrolling.multiplier = 5;
  #    selection.save_to_clipboard = true;
  #  };
  #};

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
