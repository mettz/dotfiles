{ inputs, pkgs, lib, config, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "ls --color -a";
      ll = "ls --color -la";
      df = "df -h";
      du = "du -h";
      mkdir = "mkdir -p";
    };
  };
}
