#!/usr/bin/env bash

files="vimrc zshrc tmux.conf conkyrc perlcriticrc wallpapers Xresources ncmpcpp"
scripts=""

set -e

realpath_portable() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

mydir=$(dirname $(realpath_portable "$0"))
olddir=$mydir/dotfiles.old

if [[ -f "$olddir" ]] ; then
    echo "Making $olddir for backups"
    mkdir -p "$olddir"
fi

cd "$mydir"

for file in $files; do
    if [[ -f "$HOME/.$file" && ! -L "$HOME/.$file" ]] ; then
        mv "$HOME"/."$file" "$olddir"
    fi
    ln -f -s "$mydir"/"$file" "$HOME"/."$file"
done

if [[ ! -d "$HOME/bin" ]]; then
    mkdir "$HOME/bin"
fi

for script in $scripts; do
    if [[ ! -L "$HOME/bin/$script" ]]; then
        mv "$HOME/bin/$script" "$olddir"
    fi
    ln -f -s "$mydir/scripts/$script" "$HOME/bin/$script"
done

# stuff in ~/.config:
# note: -printf doesn't work on BSD find (ugh)
find "$mydir"/config -type f -exec bash -c 'destfile="$HOME/.config${0#'"$mydir/config"'}"; destdir=$(dirname "${destfile}"); mkdir -vp "${destdir}"; ln -sfv "${0}" "${destfile}" ' {} \;

# Supporting stuff for vim
mkdir -p "$HOME/.vim/"{autoload,bundle,colors}

curl -Sso ~/.vim/autoload/pathogen.vim \
     https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

curl -Sso ~/.vim/colors/zenburn \
     https://raw.github.com/jnurmine/Zenburn/master/colors/zenburn.vim

cd "$HOME/.vim/bundle"

if [[ ! -d tagbar ]] ; then
    git clone https://github.com/majutsushi/tagbar.git
else
    cd tagbar; git pull; cd ..
fi

if [[ ! -d syntastic ]] ; then
    git clone https://github.com/scrooloose/syntastic.git
else
    cd syntastic; git pull; cd ..
fi

# luaenv and luarocks
cd $HOME
if [[ ! -d "$HOME/.luaenv" ]] ; then
    git clone https://github.com/cehoffman/luaenv.git "$HOME/.luaenv"
    git clone https://github.com/cehoffman/lua-build.git "$HOME/.luaenv/plugins/lua-build"
else
    cd "$HOME/.luaenv"; git pull
    cd "$HOME/.luaenv/plugins/lua-build"; git pull
fi


# Plenv
cd $HOME
if [[ ! -d "$HOME/.plenv" ]] ; then
    git clone https://github.com/tokuhirom/plenv.git "$HOME/.plenv"
    git clone https://github.com/tokuhirom/Perl-Build.git "$HOME/.plenv/plugins/perl-build"
else
    cd "$HOME/.plenv"; git pull
    cd "$HOME/.plenv/plugins/perl-build"; git pull
fi

# pyenv
cd $HOME
if [[ ! -d "$HOME/.rbenv" ]] ; then
    git clone https://github.com/yyuu/pyenv.git "$HOME/.pyenv"
else
    cd "$HOME/.pyenv"; git pull
fi

# rbenv
cd $HOME
if [[ ! -d "$HOME/.rbenv" ]] ; then
    git clone https://github.com/sstephenson/rbenv.git "$HOME/.rbenv"
    git clone https://github.com/sstephenson/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
else
    cd "$HOME/.rbenv"; git pull
    cd "$HOME/.rbenv/plugins/ruby-build"; git pull
fi

# setup system-specific aliases
case $(uname) in
  "Darwin")
      echo "alias ls='ls -F -G'" > "$HOME/.aliases"
      echo "alias grep='grep -i -H -n --color=auto'" >> "$HOME/.aliases"
      ;;
  "Linux")
      echo "alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first'" > "$HOME/.aliases"
      echo "alias grep='grep -i -H -n -T --color=auto'" >> "$HOME/.aliases"
      ;;
  *) echo "What system is this? Fix me!" ;;
esac

