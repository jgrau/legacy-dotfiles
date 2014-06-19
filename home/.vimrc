" Setup Bundle Support {
     execute pathogen#infect()
     call pathogen#helptags()
" }

" Basics {
  set nocompatible " No vi compatility
  let mapleader="," " Mapleader
" }

" General {
  filetype plugin indent on " Automatically change file types.

  "folding settings
  set foldmethod=indent   "fold based on indent
  set foldnestmax=10      "deepest fold is 10 levels
  set nofoldenable        "dont fold by default
  set foldlevel=1         "this is just what i use

  "set autochdir " Automatically always switch to the current files directory.
  set shortmess=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
  set history=1000 " Keep (a lot) more history

  " No needs for backups, I have Git for that
  set noswapfile
  set nobackup

  " Source the vimrc file after saving it
  if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
  endif
  "
  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  " For some reason this makes command line gems work. RVM issue i think
  set shell=/bin/sh

  map <Leader>s :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" }

" Vim UI {
  if &t_Co >= 256 || has("gui_running")
    colorscheme solarized
    set background=dark
  endif

  if &t_Co > 2 || has("gui_running")
  " switch syntax highlighting on, when the terminal has colors
    syntax on
  endif

  set ruler " Enable cursor position
  set showcmd  " Show incomplete CMDS at the bottom
  set autoread " Auto read when file is changed
  set hidden " Hide buffers, rather than close them
  set showmatch " Show matching of: () [] {}
  set matchpairs+=<:> " Match <> (HTML)
  " set number  " always show line numbers"

  " Searching {
    set ignorecase " Case insensitive search
    set smartcase " Case sensitive when uppercase is present
    set incsearch " Search as you type
    " set hlsearch " Highlight search matches
  " }

  au FocusLost * :wa " Save when losing focus

  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
  set pastetoggle=<F2>

  " GVim {
    if has("gui_running")
      color solarized " GUI Colorscheme
      set background=dark
      set guifont=Menlo\ Regular\ for\ Powerline:h12
      set lines=999 columns=9999 " Start full screen

      " GVIm options {
        set guioptions-=m " Remove menu bar
        set guioptions-=T " Remove toolbar with icons
        set guioptions-=r " Remove scrollbars (http://vimdoc.sourceforge.net/htmldoc/options.html#%27guioptions%27)
        set guioptions-=l
        set guioptions-=L
      " }

      " Title {
        if has('title')
          set titlestring=
          set titlestring+=%f\                                              " file name
          set titlestring+=%h%m%r%w                                         " flags
          set titlestring+=\ -\ %{v:progname}                               " program name
          set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
        endif
      " }
    endif
  " }

  " MVIM {
    if has("gui_macvim")
      set wildignore+=vendor/bundle/**
      set wildignore+=bin/**
      set guifont=Menlo\ Regular\ for\ Powerline:h12
      set transparency=7
    endif
  " }
" }

" Formatting {
  " Be smart, and awesome, about indentation
  set smartindent
  set copyindent
  set smarttab
  set expandtab " Tabs are spaces

  "set sw=2
  "set sts=2
  set tabstop=2 " Tabs are 2 spaces
  set backspace=2 " Backspace back 2 spaces
  set shiftwidth=2 " Even if there are tabs, preview as 2 spaces

  " Man pager
  let $PAGER=''
" }

" Key Mapping {
  " Press i to enter insert mode, and ii to exit.
  imap ii <Esc>
  map <S-C-J> <C-W>j<C-W>_
  map <S-C-K> <C-W>k<C-W>_
  map <S-C-L> <C-W>l<C-W>_
  map <S-C-H> <C-W>h<C-W>_
  map <S-C-K> <C-W>k<C-W>_
  map <C-J> <C-W>j
  map <C-K> <C-W>k
  map <C-L> <C-W>l
  map <C-H> <C-W>h
  map <C-K> <C-W>k
  map <S-H> gT
  map <S-L> gt

  " Shift key fixes
  " cmap W w
  " cmap WQ wq
  " cmap wQ wq
  " cmap Q q

  " Quickly edit/reload the vimrc file
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  nmap <silent> <leader>sv :so $MYVIMRC<CR>

  " Quick yanking to the end of the line
  nmap Y y$

  " Jump to matching pairs easily, with Tab
  nnoremap <Tab> %
  vnoremap <Tab> %

  " Key mappings
  :noremap ,d :bd<CR>
  cmap w!! w !sudo tee %
  map ,c :cd %:p:h<CR>
" }


" Plugins {
  " NerdTree {
    let NERDTreeChDirMode = 1
    let NERDTreeWinSize=20
    let NERDTreeQuitOnOpen=1


    :noremap ,n :NERDTreeToggle<CR>
  " }

  " Gist {
    let g:gist_detect_filetype = 1
    let g:gist_open_browser_after_post = 1
  " }

  " AutoCloseTag {
    " .. for XML and XHTML as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
  " }

  " Delimitmate {
    au FileType * let b:delimitMate_autoclose = 1
  " }

  " Fugitive {
    map <Leader>gc :Gcommit
    map <Leader>gs :Gstatus
  " }

  " Surround {
    let b:surround_{char2nr('=')} = "<%= \r %>"
    let b:surround_{char2nr('-')} = "<% \r %>"
  " }
  "
  " Syntastic {
    let g:syntastic_ruby_checkers = ['mri', 'rubocop']
    let g:syntastic_coffee_coffeelint_args="-f .coffeelint.json"
    let g:syntastic_quiet_messages = {'level': 'warnings'}
    let g:syntastic_mode_map = { 'passive_filetypes': ['ruby'] }
  " }

  " Airline {
    let g:airline_powerline_fonts = 1
  " }
  "
  " Tabular {
  if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
  endif
  " }

  " Vroom
  let g:vroom_write_all = 1
  let g:vroom_use_spring = 1
  let g:vroom_test_unit_command = 'testunit'

  " Ctrlp
  let g:ctrlp_map = '<Leader>t'
  let g:ctrlp_cmd = 'CtrlP'

  " Ctrlp + ctags
  nnoremap <leader>y :CtrlPTag<cr>

  " ctags + tagbar
  noremap <silent> <Leader>b :TagbarToggle<CR>


  " Ruby block told me to
  runtime macros/matchit.vim

" }

