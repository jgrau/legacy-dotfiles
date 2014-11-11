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
  set foldmethod=indent " fold based on indent
  set foldnestmax=10    " deepest fold is 10 levels
  set nofoldenable      " dont fold by default
  set foldlevelstart=0

  " Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za

  " "Refocus" folds
  nnoremap ,z zMzvzz

  "set autochdir " Automatically always switch to the current files directory.
  " set shortmess=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
  " set history=1000 " Keep (a lot) more history

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
  " set shell=/bin/sh
  set shell=$SHELL\ -l  " load shell for ruby version etc.

  set list " Highlight trailings, stolen from @teoljungberg
  set listchars=tab:>-,trail:.,extends:>,precedes:<

  set tags=.git/tags " Use commit hook tags, see ~/.git_template
" }

" Vim UI {
  if &t_Co >= 256 || has("gui_running")
    colorscheme solarized
    set background=dark
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
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
  " set pastetoggle=<F2>

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
      set wildignore+=*/tmp/*,*.so,*.swp,*.zip
      set guifont=Menlo\ Regular\ for\ Powerline:h12
      set transparency=7
    endif
  " }
" }

" Key Mapping {
  " Press i to enter insert mode, and ii to exit.
  imap ii <Esc>
  map <C-J> <C-W>j
  map <C-K> <C-W>k
  map <C-L> <C-W>l
  map <C-H> <C-W>h
  map <C-K> <C-W>k

  " Move lines
  nnoremap ∆ :m .+1<CR>==
  nnoremap ˚ :m .-2<CR>==
  inoremap ∆ <Esc>:m .+1<CR>==gi
  inoremap ˚ <Esc>:m .-2<CR>==gi
  vnoremap ∆ :m '>+1<CR>gv=gv
  vnoremap ˚ :m '<-2<CR>gv=gv

  nnoremap <A-j> :m .+1<CR>==
  nnoremap <A-k> :m .-2<CR>==
  inoremap <A-j> <Esc>:m .+1<CR>==gi
  inoremap <A-k> <Esc>:m .-2<CR>==gi
  vnoremap <A-j> :m '>+1<CR>gv=gv
  vnoremap <A-k> :m '<-2<CR>gv=gv

  " Quickly edit/reload the vimrc file
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  nmap <silent> <leader>sv :so $MYVIMRC<CR>

  " Quick yanking to the end of the line
  nmap Y y$

  " Key mappings
  :noremap ,d :bd<CR>
  cmap w!! w !sudo tee %
  map ,c :cd %:p:h<CR>

  " Ruby 1.8 -> 1.9 Hash syntax
  map <Leader>s :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>
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
    map <Leader>gs :Gstatus<CR>
  " }

  " Git Comment {
    let g:github_user = 'jgrau'
  " }

  " Surround {
    let b:surround_{char2nr('=')} = "<%= \r %>"
    let b:surround_{char2nr('-')} = "<% \r %>"
  " }

  " Syntastic {
    let g:syntastic_ruby_checkers = ['mri', 'rubocop']
    let g:syntastic_coffee_coffeelint_args="-f .coffeelint.json"
    let g:syntastic_mode_map = { 'passive_filetypes': ['ruby'] }
    let g:syntastic_always_populate_loc_list = 1
  " }

  " Airline {
    let g:airline_powerline_fonts = 1
  " }

  " Tabular {
  if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>

    " Align ruby symbol hashes on the hash marker
    AddTabularPattern! rbshash /\s\?\w\+:[^:]/l0l0
    AddTabularPattern! rbhash /^[^=]*\zs=>

    " Mappings for ruby hash rocket and symbol hashes
    " nnoremap <silent> <Leader>ahr :Tabularize rbhash<CR>
    " vnoremap <silent> <Leader>ahr :Tabularize rbhash<CR>
    " nnoremap <silent> <Leader>ahs  :Tabularize rbshash<CR>
    " vnoremap <silent> <Leader>ahs  :Tabularize rbshash<CR>
  endif
  " }

  " Rails testing {
    " Test runner {
      map <leader>R :wa<CR>:.Rrunner<CR>
      map <leader>r :wa<CR>:Rrunner<CR>
    " }

    " Vroom {
      " let g:vroom_use_spring = 1
      " let g:vroom_use_dispatch = 1
      " let g:vroom_clear_screen = 1
      " let g:vroom_use_colors = 1
      " let g:vroom_use_vimux = 1
    " }
    "
    " Thoughbot rspec.vim {
      let g:rspec_command = "Dispatch rspec {spec}"
      map <Leader>r :call RunCurrentSpecFile()<CR>
      map <Leader>R :call RunNearestSpec()<CR>
      map <Leader>l :call RunLastSpec()<CR>
      map <Leader>a :call RunAllSpecs()<CR>
    " }
  " }

  " Ctrlp
  let g:ctrlp_map = '<Leader>t'
  let g:ctrlp_cmd = 'CtrlP'

  " Ctrlp + ctags
  nnoremap <leader>y :CtrlPTag<cr>

  " ctags + tagbar
  noremap <silent> <Leader>b :TagbarToggle<CR>

  " Ruby block told me to
  runtime macros/matchit.vim

  " Flay
  let g:flay_on_open = 0
  let g:flay_on_save = 0

  " Reek
  let g:reek_always_show = 0
  let g:reek_on_loading = 0

  " Github Comment
  let g:github_user = 'jgrau'
" }

" Functions {
" Rename current file, thanks Gary Bernhardt via Ben Orenstein
  function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
      exec ':saveas ' . new_name
      exec ':silent !rm ' . old_name
      redraw!
    endif
  endfunction
  map <leader>mv :call RenameFile()<cr>

  " Copy current buffer path relative to root of VIM session to system clipboard
  nnoremap <Leader>ip :let @*=expand("%")<cr>:echo "Copied file path to clipboard"<cr>

  " Copy current filename to system clipboard
  nnoremap <Leader>if :let @*=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>

  " Copy current buffer path without filename to system clipboard
  nnoremap <Leader>id :let @*=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>
" }
