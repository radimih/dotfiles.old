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
" Клавиши <Leader> должны определяться до загрузки плагинов
"-------------------------------------------------------------------------------
let mapleader = ','
let maplocalleader = ' '

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
Plug 'Xuyuanp/nerdtree-git-plugin'

" Комментировать/раскомментировать блоки текста
Plug 'scrooloose/nerdcommenter'

" Аналог CtrlP, но быстрее
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Поддержка вложений (folding) в Markdown-файлах
Plug 'nelstrom/vim-markdown-folding'

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
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1


" -- NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
let NERDTreeIgnore = ['\,pyc$', '__pycache__$']
let NERDTreeAutoDeleteBuffer = 1
" autocmd VimEnter * NERDTree
" Стартовать плагин, если vim запущен без аргументов
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Закрывать vim, если осталось только окно плагина
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -- NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1

" -- deoplete
" let g:deoplete#enable_at_startup = 1
" " use tab to forward cycle
" inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" " use tab to backward cycle
" inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" " Close the documentation window when completion is done
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

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

filetype plugin indent on

set ignorecase
set smartcase

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"set splitbelow
"set splitright

set foldmethod=marker
set foldlevelstart=0

if has('mouse')
	set mouse= " a
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
set scrolloff=5
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

" Раскрывать/закрывать вложение (fold)
nnoremap <Space> za
vnoremap <Space> za

" Перефокусировать текущее вложение (закрыть все вложения, переоткрыть текущее
" и расположиться в центре экрана)
nnoremap <Leader>z zMzvzz

" Оставлять выделение после сдвига (indent)
vnoremap < <gv
vnoremap > >gv

" Выделить только что вставленный текст (например, для последующего сдвига)
" Стандартная команда gv - выделить ранее выделенный текст
noremap gV `[v`]

" Y - скопировать до конца строки (аналогично командам C и D)
noremap Y y$

" Перемещаться по длиной строке как по нескольким строкам
nnoremap j gj
nnoremap k gk

" В начало и в конец строки
nnoremap H ^
nnoremap L $

" Убрать выделение найденной подстроки
nmap <silent> // :nohlsearch<CR>

" Переключение между буферами
nmap <leader>. :bnext<CR>
nmap <leader>, :bprevious<CR>

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

" Вызовы плагинов и сервисов
map <C-n> :NERDTreeToggle<CR>
" nnoremap <silent> <Leader>v :NERDTreeFind<CR>

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"-------------------------------------------------------------------------------
" Удаление пробелов в конце строк
"-------------------------------------------------------------------------------
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

autocmd BufWrite * silent call DeleteTrailingWS()

