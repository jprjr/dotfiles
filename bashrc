# .bashrc

# Source global definitions
if [[ -f /etc/bashrc ]]; then
	source /etc/bashrc
fi

function prompt_command {
  local pwd_length=22
  NEWPWD=${PWD/$HOME/\~}
  if [[ ${#NEWPWD} -gt $pwd_length ]]; then
      NEWPWD="..."${NEWPWD:(-$pwd_length)}
  fi

  case $TERM in
  xterm*vte*)
    echo -ne "\033]0;bash\007"
    ;;
  esac

  export PS1="\[\e[00;33m\]\u\[\e[0m\]\[\e[00;36m\]@\h\[\e[0m\] $NEWPWD \\$ "
}

# path settings
#luaenv 
PATH="$HOME/.luaenv/bin:$PATH"
eval "$(luaenv init -)"

#plenv path
PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

#pyenv path
PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#rbenv path
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH
export EDITOR="vim"


# options for interactive sessions only
if [[ -n "$PS1" ]]; then

  PROMPT_COMMAND=prompt_command

  if which dircolors > /dev/null; then
      eval $(dircolors ~/.dircolors)
  else
      export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
  fi

  export PROMPT_COMMAND

  if [[ -f "$HOME/.aliases" ]]; then
    source "$HOME/.aliases"
  fi

  if [[ -f "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
  fi
fi

