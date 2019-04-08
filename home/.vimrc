" My vim configuration
"
" See github.com/bsmith89/dotfiles for more information.

" Anything that needs to happen before everything else.
" nocompatible should NOT need to be set, because the mere presence of
" a .vimrc indicates as much.
set nocompatible

"  Auto-Install 'junegunn/vim-plug'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')

" Load these plugins only when not using neovim
if !has('nvim')
  Plug 'noahfrederick/vim-neovim-defaults'
endif

" Load these plugins only when using neovim
if has('nvim')
endif

" Load these plugins always
Plug 'morhetz/gruvbox'  " Colorscheme
Plug 'christoomey/vim-tmux-navigator'
Plug 'sjl/vitality.vim'  " Apparently improves interaction with tmux/iterm
Plug 'itchyny/lightline.vim'  " Better looking statusline
Plug 'mbbill/undotree'  " Visualize the undo-tree
Plug 'tpope/vim-surround'  " Add and remove parens/etc. in normal.
Plug 'Raimondi/delimitMate'  " 
Plug 'tomtom/tcomment_vim'  " Add/subtract commenting levels
Plug 'chrisbra/csv.vim'  " CSV ft
Plug 'ivan-krukov/vim-snakemake'  " Smake ft
Plug 'tpope/vim-rsi'  " Use readline/emacs style cursor moving
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()
" --------------------------------END Plugins--------------------------------- }-
"  Configuration {{{1
" -----------------------------------------------------------------------------

let mapleader=","             " change the leader to be a comma vs slash
if !has("nvim")
    set noesckeys                 " No <Esc> imappings.  Instant escape.
endif

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

" on hitting side, move by just N characters
set sidescroll=3

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
if has('relativenumber') || has('nvim')
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
        autocmd BufEnter * :set norelativenumber
        autocmd BufLeave * :set relativenumber
    augroup END
    set numberwidth=1             " using only 1 column (and 1 space) while possible

    nnoremap : :set norelativenumber<CR>:
    nnoremap / :set norelativenumber<CR>/
    nnoremap ? :set norelativenumber<CR>?
endif

if has("colorcolumn") || has('nvim')
    set colorcolumn=79

    " Plug:morhetz/gruvbox
    let g:gruvbox_italic=0
    let g:gruvbox_undercurl=0
endif
colorscheme gruvbox

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:›―,eol:¬,trail:·,precedes:⋘,extends:⋙,nbsp:‿
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

set cursorline              " have a line indicate the cursor location
set cursorcolumn

set scrolloff=3             " Keep 3 context lines above and below the cursor

set nowrap                  " don't wrap text
set linebreak               " don't wrap text in the middle of a word

if has("spell") || has('nvim')
    set spelllang=en_us
endif
nnoremap <Leader>s :setlocal spell!<CR>:set spell?<CR>

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

" Plug:christoomey/vim-tmux-navigator
" " Not clear why this one direction ain't working:
" nnoremap <C-j> :TmuxNavigateDown<CR>
inoremap <C-h> <Esc>:TmuxNavigateLeft<CR>
inoremap <C-j> <Esc>:TmuxNavigateDown<CR>
inoremap <C-k> <Esc>:TmuxNavigateUp<CR>
inoremap <C-l> <Esc>:TmuxNavigateRight<CR>
if exists(':tmap')
    tnoremap <C-h> <C-\><C-N>:TmuxNavigateLeft<CR>
    tnoremap <C-j> <C-\><C-N>:TmuxNavigateDown<CR>
    tnoremap <C-k> <C-\><C-N>:TmuxNavigateUp<CR>
    tnoremap <C-l> <C-\><C-N>:TmuxNavigateRight<CR>
endif


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
"  Editing Text {{{2
" -----------------------------------------------------------------------------
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window
let g:deoplete#enable_at_startup = 1

set thesaurus+=$HOME/.vim/mthesaur.txt

set backspace=2             " Allow backspacing over autoindent, EOL, and BOL

" Automatically insert the comment leader on subsequent lines.
set formatoptions+=r

set showmatch               " Briefly jump to a paren once it's balanced

" TODO: In visual modes, surround with 's' and replace with 'S'

" Delete whole words on <M-BS>
imap <M-BS> <Esc>ldbi

" Remove trailing whitespace
vnoremap <Leader>S :s:\s\+$::<CR>

" Carry out the macro stored in the @q
nnoremap <Leader>q @q

nnoremap <Leader>p :set paste!<CR>

" Break the current line at the cursor
nnoremap K i<Enter><Esc>k$
nnoremap gK i<Enter><Esc>Vk=$

" Remove pre-line-terminus whitespace
nnoremap <Leader>S :%s:\s\+$::<Enter>

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
"  Command Line Editing {{{2
" -----------------------------------------------------------------------------
set wildmenu                  " menu completion in command mode on <Tab>
set wildmode=longest,list     " <Tab> cycles between all matching choices.

" -----------------------------------------------------------------------------
"  Executing External Commands {{{2
" -----------------------------------------------------------------------------
if has('nvim')
    let g:python3_host_prog=$HOME.'/.vim/.venv/bin/python3'
endif

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

" Open a terminal window on <Leader>t
nnoremap <Leader>t :split<CR>:terminal<CR>

" Plug:mbbill/undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" ---------------------------END Configuration---------------------------------
" -----------------------------------------------------------------------------
" Finally {{{1
" -----------------------------------------------------------------------------

if !empty(glob("~/.vimrc_local"))
   source $HOME/.vimrc_local
endif


" Run these things only once
if exists("b:did_vimrc") | finish | endif
let b:did_vimrc = 1

set encoding=utf-8
