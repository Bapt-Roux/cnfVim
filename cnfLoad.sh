#!/usr/bin/env bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

### 
# Export  init.vim as simlink
################################################################################
### Vim config
mkdir -p ~/.config/nvim/
nvim_config=init.vim
nvim_trgt_path=~/.config/nvim/init.vim
vim_trgt_path=~/.vimrc
ln -i -s $SCRIPTPATH/$nvim_config $nvim_trgt_path
ln -i -s $SCRIPTPATH/$nvim_config $vim_trgt_path
