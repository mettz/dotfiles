{ inputs, pkgs, systemSettings, ... }:

let
  system = systemSettings.system;
  extensions = inputs.nix-vscode-extensions.extensions.${system};
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      extensions.vscode-marketplace.catppuccin.catppuccin-vsc
      extensions.vscode-marketplace.yzhang.markdown-all-in-one
    ];
  };
}
