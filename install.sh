#!/usr/bin/env bash

if [ ! -d ~/.termux ]; then
    mkdir ~/.termux
fi

cat > ~/.termux/colors.properties <<EOF
background              : #292D3E
foreground              : #eceff1

color0                          : #263238
color8                          : #37474f
color1                          : #ff9800
color9                          : #ffa74d
color2                          : #8bc34a
color10                         : #9ccc65
color3                          : #ffc107
color11                         : #ffa000
color4                          : #03a9f4
color12                         : #81d4fa
color5                          : #e91e63
color13                         : #ad1457
color6                          : #009688
color14                         : #26a69a
color7                          : #cfd8dc
color15                         : #eceff1
EOF

curl -sfLo hackfont/hack.zip --create-dirs \
         https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip

unzip hackfont/hack.zip -d hackfont/
    cp hackfont/ttf/Hack-Regular.ttf ~/.termux/font.tff
    rm -r hackfont

pkg update -y
pkg install -y zsh vim

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

cat > ~/.zshrc <<EOF
export ZSH=\$HOME/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_DIR_HOME_BACKGROUND="green"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="magenta"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="red"
POWERLEVEL9K_DIR_PATH_HIGHLIGHT_FOREGROUND="black"
POWERLEVEL9K_DIR_PATH_SEPARATOR_FOREGROUND="black"

DISABLE_UPDATE_PROMPT=true

plugins=(
    git
)

source \$ZSH/oh-my-zsh.sh

unsetopt share_history
EOF

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat > ~/.vimrc <<EOF
call plug#begin('~/.vim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

if (has("nvim"))
  let \$NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

if !has('gui_running')
      set t_Co=256
endif

if &term =~ '256color'
    set t_ut=
endif

let g:lightline = {'colorscheme': 'palenight'}
let g:palenight_terminal_italics=1

set background=dark
colorscheme palenight

map <C-n> :NERDTreeToggle<CR>

syntax on
set ff=unix
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
set number
set noshowmode
set laststatus=2
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
EOF
