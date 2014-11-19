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
if [[ ! -d "$HOME/.pyenv" ]] ; then
    git clone https://github.com/yyuu/pyenv.git "$HOME/.pyenv"
    git clone https://github.com/yyuu/pyenv-virtualenv.git "$HOME/.pyenv/plugins/pyenv-virtualenv"
else
    cd "$HOME/.pyenv"; git pull
    cd "$HOME/.pyenv/plugins/pyenv-virtualenv"; git pull
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

