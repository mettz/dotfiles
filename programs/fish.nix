{ config, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_prompt_pwd_dir_length 3

      function fish_prompt
	set_color blue
	set hname (hostnamectl hostname)
	if [ $hname != "rhaenyra" ]
		echo -n $hname
	end
	if [ $PWD != $HOME ]
		set_color white
		echo -n (prompt_pwd)
	end
	set_color green
	printf '%s' (__fish_git_prompt)
	set_color purple
	echo -n '>> '
	set_color normal
      end

      set fish_greeting
    '';
    preferAbbrs = true;
    shellAbbrs = {
      e = "nvim";
      vim = "nvim";
      l = if config.programs.eza.enable then "eza -a" else "ls --color -a";
      ls = if config.programs.eza.enable then "eza -a" else "ls --color -a";
      ll = if config.programs.eza.enable then "eza -al" else "ls --color -al";
      df = "df -h";
      du = "du -sh";
      mkdir = "mkdir -p";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };
}
