HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
export PATH="$HOME/bin:$PATH"
export EDITOR="vim"
setopt nolist_beep
setopt nohist_beep
bindkey -v

# Completion style
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/john/.zshrc'

autoload -Uz compinit
compinit

# adam1 prompt
autoload promptinit
promptinit
prompt adam1

#luaenv path
PATH="$HOME/.luaenv/shims:$HOME/.luaenv/bin:$PATH"

#plenv path
PATH="$HOME/.plenv/shims:$HOME/.plenv/bin:$PATH"

#pyenv path
PATH="$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH"

#rbenv path
PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"

export PATH

if [[ -f "$HOME/.aliases" ]]; then
    source "$HOME/.aliases"
fi

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

