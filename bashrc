# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export PROMPT_COMMAND='echo -ne "\033kbash\033\\"'

# User specific aliases and functions
eval $(dircolors ~/.dircolors)

if [[ -f "$HOME/.aliases" ]]; then
  source "$HOME/.aliases"
fi
