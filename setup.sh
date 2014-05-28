#!/usr/bin/env bash

files="vimrc zshrc tmux.conf conkyrc mutt muttrc perlcriticrc wallpapers Xresources Xresources.d ncmpcpp"
scripts="tmux_mail_count.sh"

set -e

realpath_portable() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

mydir=$(dirname $(realpath_portable "$0"))
olddir=$mydir/dotfiles.old

#if [[ -f "$olddir" ]] ; then
#    echo "Making $olddir for backups"
#    mkdir -p "$olddir"
#fi

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
    if [[ -f "$HOME/bin/$script" && ! -L "$HOME/bin/$script" ]]; then
        mv "$HOME/bin/$script" "$olddir"
    fi
    ln -f -s "$mydir/scripts/$script" "$HOME/bin/$script"
done

# stuff in ~/.config:
# note: -printf doesn't work on BSD find (ugh)
find "$mydir"/config -type f -exec bash -c 'destfile="$HOME/.config${0#'"$mydir/config"'}"; destdir=$(dirname "${destfile}"); mkdir -vp "${destdir}"; ln -sfv "${0}" "${destfile}" ' {} \;

# Supporting stuff for vim
mkdir -p "$HOME/.vim/"{autoload,bundle,colors,colors-git}



cd "$HOME"/.vim/colors-git

if [[ ! -d Zenburn ]] ; then
    git clone https://github.com/jnurmine/Zenburn
else
    cd Zenburn; git pull; cd ..
fi

ln -sf "$HOME/.vim/colors-git/Zenburn/colors/zenburn.vim" \
  "$HOME/.vim/colors/zenburn.vim"


cd "$HOME/.vim/bundle"

if [[ ! -d vim-pathogen ]] ; then
    git clone https://github.com/tpope/vim-pathogen.git
else
    cd vim-pathogen; git pull; cd ..
fi

ln -sf "$HOME/.vim/bundle/vim-pathogen/autoload/pathogen.vim" \
  "$HOME/.vim/autoload/pathogen.vim"

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

if [[ ! -d vim-airline ]] ; then
    git clone https://github.com/bling/vim-airline.git
else
    cd vim-airline; git pull; cd ..
fi

if [[ ! -d vim-colors-solarized ]] ; then
    git clone https://github.com/altercation/vim-colors-solarized.git
else
    cd vim-colors-solarized; git pull; cd ..
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

