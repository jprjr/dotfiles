#!/usr/bin/env bash
set -e

lua_ver=5.1.5
luarocks_ver=2.1.2

lua_maj="${lua_ver:0:3}"
lua_installed=1
luaenv versions | grep ${lua_ver} > /dev/null || lua_installed=0

if [[ $lua_installed == 0 ]] ; then
    luaenv install "${lua_ver}"
    luaenv rehash
    mkdir "luarocks-build-${luarocks_ver}"
    cd "luarocks-build-${luarocks_ver}"
    curl -R -O "http://luarocks.org/releases/luarocks-${luarocks_ver}.tar.gz"
    tar xf "luarocks-${luarocks_ver}.tar.gz"
    cd "luarocks-${luarocks_ver}"
    ./configure --prefix="$HOME/.luaenv/versions/${lua_ver}" \
      --with-lua="$HOME/.luaenv/versions/${lua_ver}" \
      --lua-version=$lua_maj
    make build
    make install
    luaenv rehash
    cd ../..
    rm -rf "luarocks-build-${luarocks_ver}"
fi
