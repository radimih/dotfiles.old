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
" Список плагинов (для установки/обновления плагинов команда :PlugInstall)
"-------------------------------------------------------------------------------
call plug#begin(expand('~/.config/nvim/plugged'))

" Разумные настройки от авторитета
Plug 'tpope/vim-sensible'

" Поддержка команды повтора '.' для сложных команд, в том числе от плагинов
Plug 'tpope/vim-repeat'

" Управление окружением (например, скобками или тэгами)
Plug 'tpope/vim-surround'

" Автоматическое переключение раскладки клавиатуры в зависимости от edit-mode
Plug 'lyokha/vim-xkbswitch'

" Современная версия Powerline (строка состояния)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Визуальная тема
Plug 'lifepillar/vim-solarized8'

" Файлер
Plug 'scrooloose/nerdtree'

" Аналог CtrlP, но быстрее
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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

" -- vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1

" -- NERDTree
let g:NERDTreeWinSize = 25
let NERDTreeIgnore = ['\,pyc$']
"autocmd VimEnter * NERDTree

" -- vim-xkbswitch
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
let g:XkbSwitchAssistSKeymap = 1    " for search lines
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

"-------------------------------------------------------------------------------
" Основные настройки редактора
"-------------------------------------------------------------------------------

set ignorecase
set smartcase

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"set splitbelow
"set splitright

if has('mouse')
	set mouse=a
endif

set confirm
set fencs=utf-8,cp1251,latin1

set spelllang=ru_ru,ru_yo,en_us
set spell

" Сохранять swapfile каждые 2 секунды бездействия
set updatetime=2000

"-------------------------------------------------------------------------------
" Визуальные настройки редактора
"-------------------------------------------------------------------------------

set colorcolumn=100
set cursorline
set number
set showmatch
set showtabline=2
set synmaxcol=200
set visualbell

"-------------------------------------------------------------------------------
" Дополнительные команды
"-------------------------------------------------------------------------------

" Позволяет записать файл под правами sudo
cnoremap w!! w !sudo tee > /dev/null %

"-------------------------------------------------------------------------------
" Определения комбинаций клавиш
"-------------------------------------------------------------------------------

let mapleader = ','
let maplocalleader = ' '

" Вызовы плагинов и сервисов
map <C-n> :NERDTreeToggle<CR>

" Перемещаться по длиной строке как по нескольким строкам
nnoremap j gj
nnoremap k gk

" Переключение между окнами: <Tab>+hjkl
nnoremap <Tab> <C-W>

" Следующее окно: Tab-Tab
nnoremap <Tab><Tab> <C-W>w

" Предыдущее окно: Shift-Tab
nnoremap <S-Tab> <C-W>W

" Следующая вкладка (Tab): Ctrl-Tab
nnoremap <C-Tab> :tabnext<CR>

" Предыдущая вкладка (Tab): Ctrl-Shift-Tab
nnoremap <C-S-Tab> :tabprevious<CR>

" Убрать выделение найденной подстроки
nmap <silent> // :nohlsearch<CR>

"-------------------------------------------------------------------------------
" Удаление пробелов в конце строк
"-------------------------------------------------------------------------------
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

autocmd BufWrite * silent call DeleteTrailingWS()

