" My vim configuration.
" https://github.com/bsmith89/dotfiles/


set nocompatible              " Don't be compatible with vi
filetype off

" ==========================================================
"  Plugins installed using vim-pluge
" ==========================================================
" Auto-Install
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
" Figure out how to fix the gutter colorscheme.

" ===================
"  Programming Tools
" ===================
Plug 'scrooloose/syntastic'

" YouCompleteMe and suggested plugins.
Plug 'valloric/YouCompleteMe', {'do': './install.sh'}

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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
Plug 'vim-scripts/taglist.vim'

"Plug 'sjl/gundo.vim'
" ---OR---
Plug 'mbbill/undotree'

" ==================
"  Filetype Plugins
" ==================
"Plug 'plasticboy/vim-markdown'
" --OR--
"Plug 'gabrielelana/vim-markdown'
" --OR--
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'LaTeX-Box-Team/LaTeX-Box'  ", {'for': ['tex', 'latex', 'plaintex']}
" --OR--
"Plug 'git://git.code.sf.net/p/vim-latex/vim-latex'

Plug 'vim-scripts/csv.vim'       ", {'for': 'csv'}

call plug#end()

set mouse=a

" Fix issues with mouse-resizing windows in TMUX
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Correct the ':W  ->   command not found' error:
" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w
command! Wq :wq

" sudo write this
cmap W! w !sudo tee % >/dev/null

" and lets make these all work in insert mode too ( <C-O> makes next cmd
"  happen as if in command mode )
imap <C-W> <C-O><C-W>

" ==========================================================
" Basic Settings
" ==========================================================
syntax enable                 " syntax highlighing
set synmaxcol=2048            " No syntax highlighting after 2048 columns
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
colorscheme solarized
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=longest,list            " <Tab> cycles between all matching choices.

" don't bell or blink
set noerrorbells
set vb t_vb=

" Open new splits below and to the right
set splitbelow
set splitright

"" Settings for autocompletion, (was managed by 'acp'):
"" Ignore these files when completing
"set wildignore+=*.o,*.obj,.git,*.pyc
"set wildignore+=eggs/**
"set wildignore+=*.egg-info/**

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

" Options for YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

" Fix the UltiSnips/YCM key-binding conflict
" Based on http://stackoverflow.com/a/22253548/1951857
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap text in the middle of a word
set autoindent              " always set autoindenting on
"set cindent                 " use c style indent if there is no indent file
set expandtab               " set noexpandtab for all filetypes needing tabs.
set tabstop=4               " <tab> inserts this many spaces
set shiftwidth=4            " an indent level is this many spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes a tabs-worth of
                            " spaces.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
                            " Is this really necessary?
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default
set tags=./tags,./TAGS,tags;~,TAGS;~
                            " Find tags files recursively up the file
                            " hierarchy.


"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

""""" Messages, Info, Status
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
"set statusline=[%l,%v\ %P%M] " Position, modified
"set statusline+=\ %f " Filename tail
"set statusline+=\ %r%h%w " Flags
"set statusline+=(
"set statusline+=%{strlen(&ft)?&ft:'none'} " Filetype
"set statusline+=,\ %{&ff}) " Encoding


set encoding=utf-8
" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>~,eol:¶,trail:~,precedes:←,extends:→
" This turns on the display defined above.
set list


""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
"set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
if has("gui_running")
    set background=light
    " Remove menu bar
    set guioptions-=m
    " Remove toolbar
    set guioptions-=T
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
endif

"if has('python')
"py << EOF
"import os.path
"import sys
"import vim
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    sys.path.insert(0, project_base_dir)
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    execfile(activate_this, dict(__file__=activate_this))
"EOF
"endif

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

"Make BASH style movement on the line in insert mode:
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

"Make BASH style movement on the command line in ex: mode.
cmap <C-a> <C-B>
" <C-e> is already mapped to end of the command line.

set thesaurus+=$HOME/.vim/mthesaur.txt


"set statusline+=\ %{SyntasticStatuslineFlag()}
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_loc_list_height=8

" Supposed to (w/ the corresponding changes to my .tmux.conf)
" allow me to use vim keys for pane movements between both apps
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.html
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

" Automatically insert the comment leader on subsequent lines.
set formatoptions+=r

"" Required for VimOrganizer (OrgMode clone) to function.
"au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
"au  BufEnter                                 *.org  call org#SetOrgFileType()

" Close all folds except for folds which must be opened to see curser
" position.
nnoremap zV zMzv

" Airline Config
" enable/disable automatic population of the `g:airline_symbols` dictionary
" with powerline symbols:
let g:airline_powerline_fonts = 1
" enable/disable enhanced tabline:
let g:airline#extensions#tabline#enabled = 1
" enable/disable displaying buffers with a single tab:
let g:airline#extensions#tabline#show_buffers = 1
" configure collapsing parent directories in buffer name:
let g:airline#extensions#tabline#fnamecollapse = 1


" Leader and it's mappings.
let mapleader=","             " change the leader to be a comma vs slash
nmap <leader>f :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Reload Vimrc
nmap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

if has("spell")
    set spelllang=en_us
    nmap <silent> <leader>s :set spell!
endif

" Syntastic errors
nnoremap <leader>o :Errors<CR>
nnoremap <leader>e :lnext<CR>
nnoremap <leader>y :lprevious<CR>
nnoremap <leader>x :lclose<CR>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

"" Set working directory
"nnoremap <leader>. :lcd %:p:h<CR>
"" How does this work, exactly?

"" Paste from clipboard
"map <leader>p "+p

" Load a local vimrc if it exists.  This section should be after everything
" in the vimrc.
if filereadable(expand("~/.vimrc_local"))
	source ~/.vimrc_local
endif
