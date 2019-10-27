#!/bin/bash -ex

sudo apt-get -y update
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
