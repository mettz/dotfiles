{ pkgs, ... }:

{
  home.packages = [
    pkgs.fzf # for completions / interactive selection
  ];
  programs.zoxide.enable = true;
}
