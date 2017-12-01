" Клавиши <Leader> {{{
" ==============================================================================
" Должны определяться до загрузки плагинов

let mapleader = ','
let maplocalleader = ' '
" }}}

" Автоматическая установка менеджера плагинов vim-plug {{{
" ==============================================================================

let vim_plug_file = expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vim_plug_file)
    silent execute '!curl -fL'
                 \ ' --create-dirs ' .
                 \ ' -o ' . vim_plug_file .
                 \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall
endif
" }}}

" Плагины: {{{
" ==============================================================================
" Для установки/обновления плагинов команда :PlugInstall

call plug#begin(expand('~/.config/nvim/plugged'))

" --- Общие {{{

" Разумные настройки от авторитета
Plug 'tpope/vim-sensible' " {{{
" }}}

" Поддержка команды повтора '.' для сложных команд, в том числе от плагинов
Plug 'tpope/vim-repeat' " {{{
" }}}

" Управление окружением (например, скобками или тэгами)
Plug 'tpope/vim-surround' " {{{
" }}}

" Автоматическое переключение раскладки клавиатуры в зависимости от edit-mode
Plug 'lyokha/vim-xkbswitch' " {{{
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchIMappings = ['ru']
    let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
    let g:XkbSwitchAssistSKeymap = 1    " for search lines
    let g:XkbSwitchNLayout = 'us'
    let g:XkbSwitchILayout = 'us'
    set keymap=russian-jcukenwin
    set iminsert=0
    set imsearch=0

    function! RestoreKeyboardLayout(key)
      call system("xkb-switch -s 'us'")
      execute 'normal! ' . a:key
    endfunction

    nnoremap <silent> р :call RestoreKeyboardLayout('h')<CR>
    nnoremap <silent> о :call RestoreKeyboardLayout('j')<CR>
    nnoremap <silent> л :call RestoreKeyboardLayout('k')<CR>
    nnoremap <silent> д :call RestoreKeyboardLayout('l')<CR>
" }}}

" Современная версия Powerline (строка состояния)
Plug 'vim-airline/vim-airline' " {{{
Plug 'vim-airline/vim-airline-themes'
    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'simple'
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#show_tab_nr = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1

    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9
" }}}

" Визуальная тема
Plug 'lifepillar/vim-solarized8' " {{{
" }}}

" Подсветка (раскраска) текста только вокруг текущего параграфа
Plug 'junegunn/limelight.vim' " {{{
    let g:limelight_conceal_ctermfg = 238
    let g:limelight_paragraph_span = 1  " Количество подсвечеваемых параграфов вокруг текущего параграфа
    let g:limelight_priority = -1  " Подсвечивать результаты поиска за пределами

    nmap <silent> <Leader><F12> :Limelight!!<CR>
    nmap <silent> <C-W><Enter> :Limelight!!<CR>
" }}}

" Режим 'ничего лишнего' (только текст)
Plug 'junegunn/goyo.vim' " {{{
    nmap <silent> <F12> :Goyo<CR>
    nmap <silent> <C-W><Space> :Goyo<CR>

    " Автоматически включить/выключить Limelight
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
" }}}

" Файлер
Plug 'scrooloose/nerdtree' " {{{
Plug 'Xuyuanp/nerdtree-git-plugin'
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeDirArrows = 1
    let g:NERDTreeWinSize = 30
    let g:NERDTreeShowBookmarks = 1
    let g:NERDTreeAutoDeleteBuffer = 1
    let g:NERDTreeIgnore = ['\,pyc$', '__pycache__$']

    map <silent> <F5> :NERDTreeToggle<CR>
    map <silent> <F6> :call NERDTreeToggleAndFind()<CR>

    function! NERDTreeToggleAndFind()
        if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
            execute ':NERDTreeClose'
        else
            execute ':NERDTreeFind'
        endif
    endfunction

    " Стартовать плагин, если vim запущен без аргументов
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    " Закрывать vim, если осталось только окно плагина
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" Комментировать/раскомментировать блоки текста
Plug 'scrooloose/nerdcommenter' " {{{
    let g:NERDSpaceDelims = 1
    let g:NERDCommentEmptyLines = 1
" }}}

" Очень быстрый поиск по файлам
Plug 'mileszs/ack.vim' " {{{
    if executable('ag')
        let g:ackprg = 'ag --vimgrep'
    endif
" }}}

" Аналог CtrlP, но быстрее
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " {{{
Plug 'junegunn/fzf.vim'
    let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-x': 'vsplit' }
" }}}

" Поддержка Python-плагинов для neovim
Plug 'roxma/python-support.nvim', { 'do': ':PythonSupportInitPython3' } " {{{
    let g:python_support_python2_require = 0
" }}}

" }}} ---

" --- Общая поддержка языков программирования {{{

" Фреймворк для автодополнений
Plug 'roxma/nvim-completion-manager'  " {{{
    let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')
    let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
    let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')

    set shortmess+=c

    " Клавиша <Tab> для выбора
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " Клавиша <Enter> закрывает окно и начинает новую строку
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" }}}

" -- deoplete
" " Close the documentation window when completion is done
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

Plug 'sheerun/vim-polyglot' " {{{
" }}}

" }}} --- programming language

" --- JavaScript {{{

" Автодополнение (требуется установленный Node.js и плагин nvim-completion-manager) {{{
if executable('npm')
    Plug 'roxma/nvim-cm-tern'
endif
" }}}

" }}} ---

" --- Markdown {{{

" Поддержка вложений (folding) в Markdown-файлах
Plug 'nelstrom/vim-markdown-folding' " {{{
" }}}

" }}} ---

" --- Python {{{

" Дополнительные Python-модули {{{
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
" }}}

" }}} ---

call plug#end()
" }}}

" Цветовая схема {{{
" ==============================================================================

 colorscheme solarized8_dark
"colorscheme solarized8_dark_low
"colorscheme solarized8_dark_high
"colorscheme solarized8_dark_flat

"colorscheme solarized8_light
"colorscheme solarized8_light_low
"colorscheme solarized8_light_high
"colorscheme solarized8_light_flat
" }}}

" Основные настройки редактора {{{
" ==============================================================================

filetype on
filetype plugin on
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
" }}}

" Визуальные настройки редактора {{{
" ==============================================================================

set colorcolumn=100
set cursorline
set number
set showmatch
set showtabline=2
set scrolloff=5
set synmaxcol=200
set visualbell
" }}}

" Дополнительные команды {{{
" ==============================================================================

" Позволяет записать файл под правами sudo
cnoremap w!! w !sudo tee > /dev/null %
" }}}

" Определения комбинаций клавиш {{{
" ==============================================================================

" <Enter> в нормальном режиме - вставить пустую строку и остаться в нормальном режиме
nnoremap <silent> <CR> i<CR><Esc>

" Перемещаться по длиной строке как по нескольким строкам
nnoremap j gj
nnoremap k gk

" В начало и в конец строки
nnoremap H ^
nnoremap L $

" Y - скопировать до конца строки (аналогично командам C и D)
noremap Y y$

" Оставлять выделение после сдвига (indent)
vnoremap < <gv
vnoremap > >gv

" Выделить только что вставленный текст (например, для последующего сдвига)
" Стандартная команда gv - выделить ранее выделенный текст
noremap gV `[v`]

" Убрать подсветку найденной подстроки
nmap <silent> // :nohlsearch<CR>

" Показывать результат поиска в центре окна
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Раскрывать/закрывать вложение (fold)
nnoremap <Space> za
vnoremap <Space> za

" Перефокусировать текущее вложение (закрыть все вложения, переоткрыть текущее
" и расположиться в центре экрана)
nnoremap <Leader>z zMzvzz

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

" }}}

" Autocommands {{{
" ==============================================================================

" Во время записи буфера: удалить пробелы в конце строк
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite * silent call DeleteTrailingWS()

" После закрытия терминала: не дожидаться нажатия <Enter>
augroup terminalCallbacks
    autocmd!
    autocmd TermClose * call feedkeys('<cr>')
augroup END

" }}}

