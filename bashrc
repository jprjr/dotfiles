# .bashrc

function prompt_command {
  # setup the prompt
  local pwd_length=22
  NEWPWD=${PWD/$HOME/\~}
  if [[ ${#NEWPWD} -gt $pwd_length ]]; then
      NEWPWD="..."${NEWPWD:(-$pwd_length)}
  fi

  case $TERM in
  xterm*vte*)
    echo -ne "\033]0;bash\007"
    ;;
#  screen*)
#    echo -ne "\033kbash\033\\"
#    ;;
  esac

  export PS1="\[\e[00;33m\]\u\[\e[0m\]\[\e[00;36m\]@\h\[\e[0m\] $NEWPWD \\$ "

}

# Source global definitions
if [[ -f /etc/bashrc ]]; then
	source /etc/bashrc
fi

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
fi

