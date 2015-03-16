" My vim configuration


"  Important {{{
" -----------------------------------------------------------------------------
set nocompatible

" --------------------------------------------------------------------------}}}
"  Plugins {{{
" -----------------------------------------------------------------------------

"  Auto-Install 'junegunn/vim-plug' {{{
" -----------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')


" --------------------------------------------------------------------------}}}
"  Moving Around, Searching, and Patterns {{{
" -----------------------------------------------------------------------------
"Plug 'edsono/vim-matchit'

" --------------------------------------------------------------------------}}}
"  Displaying Text / Syntax, Highlighting, and Spelling  {{{
" -----------------------------------------------------------------------------
" Plug 'altercation/vim-colors-solarized'
" ---OR---
Plug 'morhetz/gruvbox'

" --------------------------------------------------------------------------}}}
"  Tags {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Windows / Tabs {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Terminal {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Mouse {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Printing {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Messages and Info {{{
" -----------------------------------------------------------------------------
Plug 'bling/vim-airline'

" --------------------------------------------------------------------------}}}
"  Selecting Text {{{
" -----------------------------------------------------------------------------
"Plug 'terryma/vim-expand-region'

" --------------------------------------------------------------------------}}}
"  Editing Text {{{
" -----------------------------------------------------------------------------
"Plug 'sjl/gundo.vim'
" ---OR---
Plug 'mbbill/undotree'

Plug 'wellle/targets.vim'  " Provides additional text objects

" --------------------------------------------------------------------------}}}
"  Tabstops and Indentation {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Folding {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Diff Mode {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Mapping {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Reading and Writing Files {{{
" -----------------------------------------------------------------------------
Plug 'scrooloose/nerdtree'

" --------------------------------------------------------------------------}}}
"  Swap File {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Command Line Editing {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Executing External Commands {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Make / Quickfix {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Language {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Special Characters {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Miscellaneous {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  IDE {{{
" -----------------------------------------------------------------------------
Plug 'jmcantrell/vim-virtualenv'

Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/syntastic'

Plug 'valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'  " Default snippets for UltiSnips

Plug 'ervandew/supertab'   " Makes YCM and UltiSnips work better together

"Plug 'jiangmiao/auto-pairs'
" ---OR---
"Plug 'Raimondi/delimitMate'
" ---OR---
Plug 'Townk/vim-autoclose'

Plug 'tpope/vim-surround'

Plug 'godlygeek/tabular'

"Plug 'scrooloose/nerdcommenter'
" ---OR---
Plug 'tomtom/tcomment_vim'
" ---OR---
"Plug 'tpope/vim-commentary'

" --------------------------------------------------------------------------}}}
"  File-Specific Plugins {{{
" -----------------------------------------------------------------------------
"Plug 'plasticboy/vim-markdown'
" --OR--
"Plug 'gabrielelana/vim-markdown'
" --OR--
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'

"Plug 'LaTeX-Box-Team/LaTeX-Box'
" --OR--
"Plug 'git://git.code.sf.net/p/vim-latex/vim-latex'

Plug 'chrisbra/csv.vim'
"
" --------------------------------------------------------------------------}}}
call plug#end()
" --------------------------------END Plugins-------------------------------}}}
"  Configuration {{{
" -----------------------------------------------------------------------------

let mapleader=","             " change the leader to be a comma vs slash

"  Moving Around, Searching, and Patterns {{{
" -----------------------------------------------------------------------------
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode

set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<CR>

" --------------------------------------------------------------------------}}}
"  Displaying Text / Syntax, Highlighting, and Spelling  {{{
" -----------------------------------------------------------------------------
syntax enable                 " syntax highlighing
set synmaxcol=2048            " no syntax highlighting after 2048 columns
set number                    " display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set colorcolumn=79

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>~,eol:¶,trail:~,precedes:←,extends:→
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
let g:gruvbox_italic=1
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
    nmap <silent> <leader>s :set spell!<CR>
endif
" --------------------------------------------------------------------------}}}
"  Tags {{{

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" -----------------------------------------------------------------------------
set tags=./tags,./TAGS,tags;~,TAGS;~
                            " Find tags files recursively up the file
                            " hierarchy.

" --------------------------------------------------------------------------}}}
"  Windows / Tabs {{{
" -----------------------------------------------------------------------------
set laststatus=2            " Always show statusline, even if only 1 window.

" Open new splits below and to the right
set splitbelow
set splitright

" --------------------------------------------------------------------------}}}
"  Terminal {{{
" -----------------------------------------------------------------------------
set title                     " show title in console title bar

" --------------------------------------------------------------------------}}}
"  Mouse {{{
" -----------------------------------------------------------------------------
if has('mouse')
    set mouse=a
endif

" Fix issues with mouse-resizing windows in TMUX
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" --------------------------------------------------------------------------}}}
"  Printing {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Messages and Info {{{
" -----------------------------------------------------------------------------
" No bell beep or flash is wanted
set noerrorbells
set vb t_vb=

set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.

set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.

set ruler                   " show the cursor position all the time

set confirm                 " Y-N-C prompt if closing with unsaved changes.
" --------------------------------------------------------------------------}}}
"  Selecting Text {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Editing Text {{{
" -----------------------------------------------------------------------------
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

set thesaurus+=$HOME/.vim/mthesaur.txt

set backspace=2             " Allow backspacing over autoindent, EOL, and BOL

" Automatically insert the comment leader on subsequent lines.
set formatoptions+=r

set matchpairs+=<:>         " show matching <> (html mainly) as well
set showmatch               " Briefly jump to a paren once it's balanced

inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" Carry out the macro stored in the @q
nnoremap <leader>q @q

" Add lines above/below in normal mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" --------------------------------------------------------------------------}}}
"  Tabstops and Indentation {{{
" -----------------------------------------------------------------------------
set autoindent              " always set autoindenting on
set expandtab               " set noexpandtab for all filetypes needing tabs.
set tabstop=4               " <tab> inserts this many spaces
set shiftwidth=4            " an indent level is this many spaces wide.
" <BS> over an autoindent deletes a tabs-worth of spaces.
set softtabstop=4
set shiftround              " rounds indent to a multiple of shiftwidth

" --------------------------------------------------------------------------}}}
"  Folding {{{
" -----------------------------------------------------------------------------
set foldmethod=marker       " TODO: Does this affect all files, or just ones
                            " where foldmethod isn't set?

" Map zV to close surrounding folds
nnoremap zV zMzv
" --------------------------------------------------------------------------}}}
"  Diff Mode {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Mapping {{{
" -----------------------------------------------------------------------------
set timeoutlen=500 ttimeoutlen=10

" --------------------------------------------------------------------------}}}
"  Reading and Writing Files {{{
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
cmap W! w !sudo tee % >/dev/null
" --------------------------------------------------------------------------}}}
"  Swap File {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Command Line Editing {{{
" -----------------------------------------------------------------------------
set wildmenu                  " menu completion in command mode on <Tab>
set wildmode=longest,list            " <Tab> cycles between all matching choices.

" BASH style movements on command line
cmap <C-a> <C-B>

" --------------------------------------------------------------------------}}}
"  Executing External Commands {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Make / Quickfix {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Language {{{
" -----------------------------------------------------------------------------

" --------------------------------------------------------------------------}}}
"  Special Characters {{{
" -----------------------------------------------------------------------------
set encoding=utf-8

" --------------------------------------------------------------------------}}}
"  Miscellaneous {{{
" -----------------------------------------------------------------------------
" Supposed to (w/ the corresponding changes to my .tmux.conf)
" allow me to use vim keys for pane movements between both apps
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.html
" TODO: Consider Plug:christoomey/vim-tmux-navigator
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      " The sleep and & gives time to get back to vim so tmux's focus tracking
      " can kick in and send us our ^[[O
      execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
      redraw!
    endif
  endfunction
  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" Reload vimrc
nmap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" --------------------------------------------------------------------------}}}
"  Plugin-Specific Configuration {{{
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
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let NERDTreeShowHidden=1
nmap <leader>f :NERDTreeToggle<CR>

" Re: Plug:scrooloose/syntastic
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_loc_list_height=8

nnoremap <leader>u :UndotreeToggle<CR>

" --------------------------------------------------------------------------}}}
" ---------------------------END Configuration------------------------------}}}
