#! /bin/sh

#Edit this to the libclang library installed on your system.
#We need to use the system libclang for YouCompleteMe so it does
#not fight methodstub.
LIBCLANG_PATH='/usr/lib/libclang.so'

git submodule update --init --recursive

ln -s ~/.vim/.vimrc ~/.vimrc

cd ./bundle/YouCompleteMe
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DEXTERNAL_LIBCLANG_PATH=$LIBCLANG_PATH ../third_party/ycmd/cpp
make
