{ inputs, pkgs, userSettings, ... }:

let
  username = userSettings.username;
  shell = userSettings.shell;
in
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      iosevka-bin
      (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; }) 
    ];
  };

  users = {
    users.${username} = {
      shell = pkgs.${shell};
      uid = 1000;
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      group = username;
    };
    groups.${username} = {
      gid = 1000;
    };
  };
  programs.${shell}.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nur.overlay
    inputs.yazi.overlays.default
  ];
}