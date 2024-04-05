# Shell start
if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end

set TTY (tty)
if [ "$TTY" = "/dev/tty1" ]
    set -Ux WLR_EVDI_RENDER_DEVICE "/dev/dri/card1"
    exec Hyprland
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Abbreviations & aliases
if command -v eza > /dev/null
	abbr -a l 'eza -a'
	abbr -a ls 'eza -a'
	abbr -a ll 'eza -al'
else
	abbr -a l 'ls -a'
	abbr -a ls 'ls -a'
	abbr -a ll 'll -a'
end

# Utility functions
function dotfiles
    /usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" $argv
end

function code
	/usr/bin/code --enable-features=UseOzonePlatform --ozone-platform=wayland $argv
end

# Path modifications
set PATH $PATH "$HOME/.cargo/bin"

# Fish prompt
set -g fish_prompt_pwd_dir_length 3

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
	echo -n '> '
	set_color normal
end

set fish_greeting
