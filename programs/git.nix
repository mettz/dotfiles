{ config, pkgs, userSettings, ... }:

{
  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = true;
      core = {
        autocrlf = "input";
        safecrlf = true;
        editor = "nvim";
      };
      pull.ff = "only";
      push.default = "simple";
      help.autoCorrect = "prompt";
      github.user = "mettz";
      protocol.version = 2;
    };
    aliases = {
      c = "commit";
      s = "status";
      st = "status";
      lg = "log --oneline";
      last = "log -1 HEAD";
    };
  };
}
