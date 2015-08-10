" My vim configuration
"
"
" Plugins and options are organized loosely based on the order of
" `:options`.
"
" See github.com/bsmith89/dotfiles for more information.


"  First {{{1
" -----------------------------------------------------------------------------

" Anything that needs to happen before everything else.
" nocompatible should NOT need to be set, because the mere presence of
" a .vimrc indicates as much.
" set nocompatible

" -----------------------------------------------------------------------------
"  Plugins {{{1
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Auto-Install 'junegunn/vim-plug' {{{2
" -----------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')


" -----------------------------------------------------------------------------
"  Moving Around, Searching, and Patterns {{{2
" -----------------------------------------------------------------------------
"Plug 'edsono/vim-matchit'

" -----------------------------------------------------------------------------
"  Displaying Text / Syntax, Highlighting, and Spelling  {{{2
" -----------------------------------------------------------------------------
" Plug 'flazz/vim-colorschemes'
" Plug 'altercation/vim-colors-solarized'
" " ---AND/OR---
Plug 'morhetz/gruvbox'

" -----------------------------------------------------------------------------
"  Tags {{{2
" -----------------------------------------------------------------------------
" Plug 'ludovicchabant/vim-gutentags'

" -----------------------------------------------------------------------------
"  Windows / Tabs {{{2
" -----------------------------------------------------------------------------
" TODO: Figure out why <C-H> doesn't work.
Plug 'christoomey/vim-tmux-navigator'
Plug 'sjl/vitality.vim'

" -----------------------------------------------------------------------------
"  Terminal {{{2
" -----------------------------------------------------------------------------
Plug 'tmux-plugins/vim-tmux-focus-events'

" -----------------------------------------------------------------------------
"  Mouse {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Printing {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Messages and Info {{{2
" -----------------------------------------------------------------------------
Plug 'bling/vim-airline'

" -----------------------------------------------------------------------------
"  Selecting Text {{{2
" -----------------------------------------------------------------------------
"Plug 'terryma/vim-expand-region'

" -----------------------------------------------------------------------------
"  Editing Text {{{2
" -----------------------------------------------------------------------------
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'godlygeek/tabular'

"Plug 'sjl/gundo.vim'
" ---OR---
Plug 'mbbill/undotree'

Plug 'wellle/targets.vim'  " Provides additional text objects

" -----------------------------------------------------------------------------
"  Tabstops and Indentation {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Folding {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Diff Mode {{{2
" -----------------------------------------------------------------------------

Plug 'jmcantrell/vim-diffchanges'

" -----------------------------------------------------------------------------
"  Mapping {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Reading and Writing Files {{{2
" -----------------------------------------------------------------------------

" Plug 'kien/ctrlp.vim'

Plug 'scrooloose/nerdtree'

" -----------------------------------------------------------------------------
"  Swap File {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Command Line Editing {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Executing External Commands {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Make / Quickfix {{{2
" -----------------------------------------------------------------------------

" Plug 'tpope/vim-dispatch'
" ---OR---
Plug 'benekastah/neomake'
" ---OR---
" Plug 'pgdouyon/vim-accio'

" -----------------------------------------------------------------------------
"  Language {{{2
" -----------------------------------------------------------------------------

Plug 'eagletmt/neco-ghc'

" -----------------------------------------------------------------------------
"  Special Characters {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Miscellaneous {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  IDE {{{2
" -----------------------------------------------------------------------------
" Plug 'jmcantrell/vim-virtualenv'  " This does not seem to work currently.
"                                   " NO idea why.

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/syntastic'

Plug 'valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}
"
Plug 'ervandew/supertab'   " Makes YCM and UltiSnips work better together
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'  " Default snippets for UltiSnips

" Plug 'jiangmiao/auto-pairs'
" ---OR---
Plug 'Raimondi/delimitMate'
" ---OR---
" Plug 'Townk/vim-autoclose'  " YCM claims that this causes bugs...

Plug 'tpope/vim-surround'

Plug 'godlygeek/tabular'

"Plug 'scrooloose/nerdcommenter'
" ---OR---
Plug 'tomtom/tcomment_vim'
" ---OR---
"Plug 'tpope/vim-commentary'

Plug 'ivanov/vim-ipython'

Plug 'jpalardy/vim-slime'

" -----------------------------------------------------------------------------
"  File-Specific Plugins {{{2
" -----------------------------------------------------------------------------
"Plug 'plasticboy/vim-markdown'
" --OR--
"Plug 'gabrielelana/vim-markdown'
" --OR--
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
" --OR--
" For just a few more recent commits (is this really necessary?)
Plug 'tpope/vim-markdown'

Plug 'lervag/vimtex'
" --OR--
" Plug 'LaTeX-Box-Team/LaTeX-Box'
" --OR--
"Plug 'git://git.code.sf.net/p/vim-latex/vim-latex'

Plug 'chrisbra/csv.vim'

" Plug 'freitass/todo.txt-vim'
" --OR--
Plug 'davidoc/todo.txt-vim'
" --OR--
" Plug '~/.vim/bundle/todo.txt-vim'


" -----------------------------------------------------------------------------
call plug#end()
" --------------------------------END Plugins--------------------------------- }-
"  Configuration {{{1
" -----------------------------------------------------------------------------

let mapleader=","             " change the leader to be a comma vs slash
set noesckeys                 " No <Esc> imappings.  Instant escape.

" -----------------------------------------------------------------------------
"  Moving Around, Searching, and Patterns {{{2
" -----------------------------------------------------------------------------
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode

set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" hide matches on <Leader>space
nnoremap <Leader><space> :nohlsearch<CR>

" -----------------------------------------------------------------------------
"  Displaying Text / Syntax, Highlighting, and Spelling  {{{2
" -----------------------------------------------------------------------------
"
" " FocusGained and FocusLost only works in classic vim, not nvim
" augroup testfocus
"     autocmd!
"     autocmd FocusLost   * :echom "set focus lost"
"     autocmd FocusGained * :echom "set focus gained"
"     autocmd InsertEnter * :echom "set insert enter"
"     autocmd InsertLeave * :echom "set insert leave"
"     autocmd WinEnter    * :echom "set win enter"
"     autocmd WinLeave    * :echom "set win leave"
"     autocmd CmdwinEnter * :echom "set cmdwin enter"
"     autocmd CmdwinLeave * :echom "set cmdwin leave"
" augroup END

syntax enable                 " syntax highlighing
set synmaxcol=2048            " no syntax highlighting after 2048 columns

" Use relative line numbering when focused on the pane/window in normal mode.
" TODO: Show absolute number when I'm on the command line
" is that even possible?
set number
set relativenumber
augroup linenumbers
    autocmd!
    autocmd FocusLost * :set norelativenumber
    autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
    autocmd WinEnter * :set relativenumber
    autocmd WinLeave * :set norelativenumber
    autocmd CmdwinEnter * :set norelativenumber
    autocmd CmdwinLeave * :set relativenumber
augroup END
set numberwidth=1             " using only 1 column (and 1 space) while possible


set colorcolumn=79

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:›―,eol:¶,trail:–,precedes:⋘,extends:⋙,nbsp:‿
" This turns on the display defined above.
set list

if has("gui_running")
    set background=light
    " Remove menu bar
    set guioptions-=m
    " Remove toolbar
    set guioptions-=T
    set guifont=Menlo\ for\ Powerline
else
    set background=dark
endif

" colorscheme solarized
" ---OR---
" Re: Plug:morhetz/gruvbox
let g:gruvbox_italic=0
let g:gruvbox_undercurl=0
colorscheme gruvbox
" Only because this one thing isn't working.  This is short-term fix...
" See: https://github.com/neovim/neovim/issues/2098
hi SpellBad cterm=underline

set cursorline              " have a line indicate the cursor location

set scrolloff=3             " Keep 3 context lines above and below the cursor

set nowrap                  " don't wrap text
set linebreak               " don't wrap text in the middle of a word

if has("spell")
    set spelllang=en_us
endif
nnoremap <Leader>s :setlocal spell!<CR>

" Display the highlight group on F10
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
\ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" -----------------------------------------------------------------------------
"  Tags {{{2
" -----------------------------------------------------------------------------
set tags=./tags,./TAGS,tags;~,TAGS;~
                            " Find tags files recursively up the file
                            " hierarchy.

" -----------------------------------------------------------------------------
"  Windows / Tabs {{{2
" -----------------------------------------------------------------------------
set laststatus=2            " Always show statusline, even if only 1 window.

" Open new splits below and to the right
set splitbelow
set splitright

" -----------------------------------------------------------------------------
"  Terminal {{{2
" -----------------------------------------------------------------------------
set title                     " show title in console title bar

" TODO: Fix up this script so it actually works.
" TODO: Build a generalizable way to call filters in ~/.vim/filters
vnoremap <Leader>gq :! ~/.vim/filters/proform<Enter>

if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" -----------------------------------------------------------------------------
"  Mouse {{{2
" -----------------------------------------------------------------------------
if has('mouse')
    set mouse=a
endif

" Fix issues with mouse-resizing windows in TMUX
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" TODO: has('terminfo') or something
if exists(':tmap')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-\> <Esc>
endif

" -----------------------------------------------------------------------------
"  Printing {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Messages and Info {{{2
" -----------------------------------------------------------------------------
" No bell beep or flash is wanted
set noerrorbells
set vb t_vb=

set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.

set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.

set ruler                   " show the cursor position all the time

set confirm                 " Y-N-C prompt if closing with unsaved changes.
" -----------------------------------------------------------------------------
"  Selecting Text {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Editing Text {{{2
" -----------------------------------------------------------------------------
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

set thesaurus+=$HOME/.vim/mthesaur.txt

set backspace=2             " Allow backspacing over autoindent, EOL, and BOL

" Automatically insert the comment leader on subsequent lines.
set formatoptions+=r

set showmatch               " Briefly jump to a paren once it's balanced

inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" TODO: In visual modes, surround with 's' and replace with 'S'

" Delete whole words on <M-BS>
imap <M-BS> <Esc>ldbi

" Carry out the macro stored in the @q
nnoremap <Leader>q @q

" " <Up>/<Down> to move the current line
" " TODO: Is this really necessary?
" nnoremap <Up> :move-2<CR>==
" nnoremap <Down> :move+<CR>==

" " Add lines above/below in normal mode
" nnoremap <Left> O<Esc>
" nnoremap <Right> o<Esc>
" " TODO: Map <S-Left>/<S-Right> to remove lines above and below *as long as
" " they're blank.
" nmap <S-Left> k:'<,'>s:^\s\+$::<CR>
" nmap <S-Right> j:'<,'>s:^\s\+$::<CR>
" " TODO: How do I get this to work?

nnoremap <Leader>p :set paste!<CR>

" " This doesn't work, but I want it to:
" " Insert a non-breaking space on Shift-Space
" nmap <S-Space> <C-k><Space><Space>

" -----------------------------------------------------------------------------
"  Tabstops and Indentation {{{2
" -----------------------------------------------------------------------------
set autoindent              " always set autoindenting on
set expandtab               " set noexpandtab for all filetypes needing tabs.
set tabstop=4               " <tab> inserts this many spaces
set shiftwidth=4            " an indent level is this many spaces wide.
" <BS> over an autoindent deletes a tabs-worth of spaces.
set softtabstop=4
set shiftround              " rounds indent to a multiple of shiftwidth

" -----------------------------------------------------------------------------
"  Folding {{{2
" -----------------------------------------------------------------------------
set foldmethod=marker       " TODO: Does this affect all files, or just ones
                            " where foldmethod isn't set?

function! FoldColumnToggle()
    if &foldcolumn > 0
        echom "foldcolumn=0"
        let &foldcolumn=0
    else
        echom "foldcolumn>0"
        let &foldcolumn=1
    endif
    return &foldcolumn
endfunction
nnoremap <silent> <Leader>F :call FoldColumnToggle()<CR>

" Map zV to close surrounding folds
nnoremap zV zMzv
" -----------------------------------------------------------------------------
"  Diff Mode
" -----------------------------------------------------------------------------

nnoremap <silent> <Leader>D :DiffChangesDiffToggle<CR>

" -----------------------------------------------------------------------------
"  Mapping {{{2
" -----------------------------------------------------------------------------
" set timeoutlen=500 ttimeoutlen=10

" May make typeing a 'j' slower.
inoremap jk <Esc>

" I don't really use ';' for anything anyway.
nnoremap ; :
nnoremap <Leader>; ;

" -----------------------------------------------------------------------------
"  Reading and Writing Files {{{2
" -----------------------------------------------------------------------------
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.

set fileformats=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W    :w            " Correct the ':W  ->   command not found' error:
command! Wq   :wq
command! WQ   :wq
command! -bang Q :q<bang>
" sudo write this
cnoremap W! w !sudo tee % >/dev/null

" -----------------------------------------------------------------------------
"  Swap File {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Command Line Editing {{{2
" -----------------------------------------------------------------------------
set wildmenu                  " menu completion in command mode on <Tab>
set wildmode=longest,list            " <Tab> cycles between all matching choices.

" BASH style movements on command line
cnoremap <C-a> <C-B>

" -----------------------------------------------------------------------------
"  Executing External Commands {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Make / Quickfix {{{2
" -----------------------------------------------------------------------------
nnoremap <Leader>m :w<CR>:Neomake!<CR>

" -----------------------------------------------------------------------------
"  Language {{{2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  Special Characters {{{2
" -----------------------------------------------------------------------------
set encoding=utf-8

" -----------------------------------------------------------------------------
"  Miscellaneous {{{2
" -----------------------------------------------------------------------------

" TODO: Make this source nvimrc not vimrc when appropriate
" Reload vimrc
nnoremap <silent> <Leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Open vimrc as a split
nnoremap <Leader>v :split ~/.vimrc<CR>
" Open after/ftplugin/ft.vim in a split
nnoremap <Leader>b :split `="$HOME/.vim/after/ftplugin/" . &ft . ".vim"`<CR>

" -----------------------------------------------------------------------------
"  Plugin-Specific Configuration {{{2
" -----------------------------------------------------------------------------
" Re: Plug:airblade/vim-gitgutter
" vim-gitgutter will use Sign Column to set its color, reload it.
call gitgutter#highlight#define_highlights()

" Re: Plug:bling/vim-airline
" enable/disable automatic population of the `g:airline_symbols` dictionary
" with powerline symbols:
let g:airline_powerline_fonts = 1
" enable/disable enhanced tabline:
let g:airline#extensions#tabline#enabled = 1
" enable/disable displaying buffers with a single tab:
let g:airline#extensions#tabline#show_buffers = 1
" configure collapsing parent directories in buffer name:
let g:airline#extensions#tabline#fnamecollapse = 1

" Re: Plug:valloric/YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files       = 1
let g:ycm_seed_identifiers_with_syntax              = 1
let g:ycm_filepath_completion_use_working_dir       = 1

" Re: Plug:eagletmt/neco-ghc
let g:ycm_semantic_triggers = {
    \ 'haskell': ['.']
    \ }

" Fix the UltiSnips/YCM key-binding conflict
" Based on http://stackoverflow.com/a/22253548/1951857
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" Re: Plug:ervandew/supertab
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
" Re: Plug:SirVer/ultisnips
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger       = "<Tab>"
let g:UltiSnipsJumpForwardTrigger  = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" Re: Plug:scrooloose/nerdtree
let NERDTreeShowHidden=1
nnoremap <Leader>f :NERDTreeToggle<CR>

" Re: Plug:scrooloose/syntastic
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_loc_list_height=8

" Re: Plug:mbbill/undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" " Re: Plug:kien/ctrlp.vim
" let g:ctrlp_show_hidden=1
" let g:ctrlp_follow_symlinks=2

" Re: Plug:'godlygeek/tabular'
nnoremap <Leader>\ :Tabularize /\| <CR>

" Re: Plug: 'jpalardy/vim-slime'
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}


" ---------------------------END Configuration---------------------------------
" -----------------------------------------------------------------------------
" Finally {{{1
" -----------------------------------------------------------------------------

" Make this work for .nvimrc_local, too.
if !empty(glob("~/.vimrc_local"))
   source $home/.vimrc_local
endif
