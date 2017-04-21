set nocompatible
set termguicolors

"-------------------------------------------------------------------------------
" Автоматическая установка менеджера плагинов vim-plug
"-------------------------------------------------------------------------------
let vim_plug_file = expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vim_plug_file)
  silent execute '!curl -fL'
                    \ ' -o ' . vim_plug_file .
                    \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

"-------------------------------------------------------------------------------
" Список плагинов
"-------------------------------------------------------------------------------
call plug#begin(expand('~/.config/nvim/plugged'))
    
Plug 'lyokha/vim-xkbswitch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
    
call plug#end()

"-------------------------------------------------------------------------------
" Настройки плагинов
"-------------------------------------------------------------------------------

" -- xkb-switch
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
let g:XkbSwitchAssistSKeymap = 1    " for search lines
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" -- vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='simple'
