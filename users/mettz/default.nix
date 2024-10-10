{ pkgs, ... }:

{
  users = {
    users.mettz = {
      shell = pkgs.fish;
      uid = 1000;
      isNormalUser = true;
      description = "Mattia";
      extraGroups = [ "networkmanager" "wheel" ];
      group = "mettz";
    };
    groups.mettz = {
      gid = 1000;
    };
  };
  programs.fish.enable = true;
}
