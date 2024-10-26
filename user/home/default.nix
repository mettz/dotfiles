{
  pkgs,
  inputs,
  systemSettings,
  userSettings,
  ...
}:

let
  username = userSettings.username;
  system = systemSettings.system;
in
{
  imports = [
    ../../programs/git.nix
    ../../programs/zoxide.nix
    ../../programs/fish.nix
    ../../programs/firefox.nix
    ../../programs/vscodium.nix
    ../../programs/libreoffice.nix
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  home.username = username;
  home.homeDirectory = "/home/" + username;

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
    dua
    fd
    wl-clipboard

    # networking tools
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    neofetch
    file
    which
    tree
    git-crypt
    inputs.agenix.packages.${system}.default

    # productivity
    btop # replacement of htop/nmon
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

    # node.js
    nodejs
    pnpm
    bun

    # gui apps
    vesktop # alternative discord client with support for screen sharing on wayland
    zathura
    zoom-us
  ];

  programs.home-manager.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.yazi = {
    enable = true;
#    shellWrapperName = "y";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    documents = null;
    music = null;
    publicShare = null;
    templates = null;
    videos = null;
  };
}
