set number
set cursorline

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
Plug 'lifepillar/vim-solarized8'
Plug 'scrooloose/nerdtree'
    
call plug#end()

"-------------------------------------------------------------------------------
" Цветовая схема
"-------------------------------------------------------------------------------

 colorscheme solarized8_dark
"colorscheme solarized8_dark_low
"colorscheme solarized8_dark_high
"colorscheme solarized8_dark_flat

"colorscheme solarized8_light
"colorscheme solarized8_light_low
"colorscheme solarized8_light_high
"colorscheme solarized8_light_flat

"-------------------------------------------------------------------------------
" Настройки плагинов
"-------------------------------------------------------------------------------

" -- vim-xkbswitch
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

"-------------------------------------------------------------------------------
" Дополнительные команды
"-------------------------------------------------------------------------------

" Позволяет записать файл под правами sudo
cmap w!! w !sudo tee > /dev/null %

