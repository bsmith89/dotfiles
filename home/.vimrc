" My vim configuration.
" https://github.com/bsmith89/dotfiles/


set nocompatible              " Don't be compatible with vi

" =========
"  Plugins
" =========
" Auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')
" =================
"  Visual Upgrades
" =================
Plug 'bling/vim-airline'
Plug 'altercation/vim-colors-solarized'

" ===================
"  Environment Tools
" ===================
Plug 'jmcantrell/vim-virtualenv'

" ==================
"  Versioning Tools
" ==================
Plug 'airblade/vim-gitgutter'

" ===================
"  Programming Tools
" ===================
Plug 'scrooloose/syntastic'
Plug 'valloric/YouCompleteMe', {'do': './install.sh'}

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'  " Default snippets for UltiSnips

"Makes YCM and UltiSnips work better together
Plug 'ervandew/supertab'

Plug 'jiangmiao/auto-pairs'
" ---OR---
"Plug 'Raimondi/delimitMate'

Plug 'godlygeek/tabular'
"Plug 'terryma/vim-expand-region'
"Plug 'edsono/vim-matchit'

"Plug 'scrooloose/nerdcommenter'
" ---OR---
"Plug 'tomtom/tcomment_vim'
" ---OR---
Plug 'tpope/vim-commentary'

" =====================
"  Navigation Upgrades
" =====================
Plug 'scrooloose/nerdtree'

" ctags navigation, reference
"Plug 'vim-scripts/taglist.vim'
" ---OR---
"Plug 'majutsushi/tagbar'
"Plug 'xolox/vim-easytags'

"Plug 'sjl/gundo.vim'
" ---OR---
Plug 'mbbill/undotree'

Plug 'wellle/targets.vim'

" ==================
"  Filetype Plugins
" ==================
"Plug 'plasticboy/vim-markdown'
" --OR--
"Plug 'gabrielelana/vim-markdown'
" --OR--
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'

"Plug 'LaTeX-Box-Team/LaTeX-Box'
" --OR--
"Plug 'git://git.code.sf.net/p/vim-latex/vim-latex'

Plug 'vim-scripts/csv.vim'       ", {'for': 'csv'}

call plug#end()

" ============
"  Top Matter
" ============
let mapleader=","             " change the leader to be a comma vs slash

" ====================
"  Computer Interface
" ====================
if has('mouse')
    set mouse=a
endif

" Fix issues with mouse-resizing windows in TMUX
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" ============================
"  Colorscheme and Appearence
" ============================
syntax enable                 " syntax highlighing
set synmaxcol=2048            " no syntax highlighting after 2048 columns
set number                    " display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set colorcolumn=79
set title                     " show title in console title bar
set wildmenu                  " menu completion in command mode on <Tab>
set wildmode=longest,list            " <Tab> cycles between all matching choices.
" No bell beep or flash is wanted
set noerrorbells
set vb t_vb=
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
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
else
    set background=dark
endif

" Re: Plug:altercation/vim-colors-solarized
colorscheme solarized

" Re: Plug:airblade/vim-gitgutter
" Sign Column made by solarized color is strange, clear it.
highlight clear SignColumn
" vim-gitgutter will use Sign Column to set its color, reload it.
call gitgutter#highlight#define_highlights()


" ==========================
"  Messages / Info / Status
" ==========================
set laststatus=2            " Always show statusline, even if only 1 window.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
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

" =========================
"  Splits / Tabs / Buffers
" =========================
" Open new splits below and to the right
set splitbelow
set splitright

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

" =========================
"  Autocompletion Settings
" =========================
""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window
set thesaurus+=$HOME/.vim/mthesaur.txt

" Re: Plug:valloric/YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files       = 1
let g:ycm_seed_identifiers_with_syntax              = 1

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


" ====================
"  Cursor Positioning
" ====================
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
" TODO: Fill this out
" Make BASH style movement on the line in insert mode:
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" =====================
"  Insert-mode Editing
" =====================
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set linebreak               " don't wrap text in the middle of a word
set nowrap                  " don't wrap text
" Automatically insert the comment leader on subsequent lines.
set formatoptions+=r


" ===========
"  Indenting
" ===========
set autoindent              " always set autoindenting on
set showmatch               " Briefly jump to a paren once it's balanced
set expandtab               " set noexpandtab for all filetypes needing tabs.
set tabstop=4               " <tab> inserts this many spaces
set shiftwidth=4            " an indent level is this many spaces wide.
" <BS> over an autoindent deletes a tabs-worth of spaces.
set softtabstop=4
set shiftround              " rounds indent to a multiple of shiftwidth

" =================
"  Reading/Writing
" =================
set encoding=utf-8
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
" Seriously, guys. It's not like :W is bound to anything anyway.
command! W    :w            " Correct the ':W  ->   command not found' error:
command! Wq   :wq
command! WQ   :wq
command! -bang Q :q<bang>
" sudo write this
cmap W! w !sudo tee % >/dev/null

" =============
"  File System
" =============
" Re: Plug:scrooloose/nerdtree
nmap <leader>f :NERDTreeToggle<CR>
let NERDTreeShowHidden=1


" ========
"  Search
" ========
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex
" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" ==============================
"  Spelling and Syntax Checking
" ==============================
" Re: Plug:scrooloose/syntastic
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_loc_list_height=8
" " Syntastic errors
" nnoremap <leader>o :Errors<CR>
" nnoremap <leader>e :lnext<CR>
" nnoremap <leader>y :lprevious<CR>
" nnoremap <leader>x :lclose<CR>

if has("spell")
    set spelllang=en_us
    nmap <silent> <leader>s :set spell!
endif

" =========
"  Ex Mode
" =========
" TODO: Make this better
" Make BASH style movement on the command line in ex: mode.
cmap <C-a> <C-B>
" <C-e> is already mapped to end of the command line.

" ===============
"  Quick Editing
" ===============
" Carry out the macro stored in the @q
nnoremap <leader>q @q

" =======
"  Misc.
" =======
set matchpairs+=<:>         " show matching <> (html mainly) as well
set tags=./tags,./TAGS,tags;~,TAGS;~
                            " Find tags files recursively up the file
                            " hierarchy.
" Map zV to close surrounding folds
nnoremap zV zMzv
" Reload Vimrc
nmap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
