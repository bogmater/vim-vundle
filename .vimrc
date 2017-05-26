set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'ctrpvim/ctrlp.vim'
Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'jwalton512/vim-blade'
Plugin 'StanAngeloff/php.vim'
Plugin 'jacoborus/tender.vim'
Plugin 'SirVer/ultisnips'
Plugin 'sjbach/lusty'
Plugin 'scrooloose/nerdtree'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/seoul256.vim'
Plugin 'pangloss/vim-javascript'

call vundle#end()

syntax on
filetype plugin indent on
set noswapfile
set nu

" colorscheme
colorscheme seoul256

" tab stuff
set expandtab ts=2 sw=2 ai

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" easier copy/paste
noremap <leader>y "+y
noremap <leader>Y "+Y
noremap <leader>p "+p

" add a $ character to end of a change
set cpoptions+=$

" correct php comments
au Bufenter *.php set comments=sl:/*,mb:*,elx:*/

" easier split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" sexy invisible chars
set list listchars=tab:▸\ ,trail:.,eol:¬

" lustyjuggler complaining stop
set hidden

" airline fonts
let g:airline_powerline_fonts = 1

" syntastic PHP
let g:syntastic_php_checkers      = ['php', 'phpmd']
" let g:syntastic_haskell_checkers  = ['ghc-mod', 'hlint']

" php documentor
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
autocmd BufRead,BufNewFile *.php nnoremap <buffer> <C-c> :call pdv#DocumentWithSnip()<CR>

" ultisnips triggers
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" don't match <> in .php files
au FileType php let b:delimitMate_matchpairs = "(:),[:],{:}"

"" phpcomplete
set completeopt=longest,menuone

" ycm semantic triggers
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind ctrl-n to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <C-n> :Ag<SPACE>

" tabular align binds on leader
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" insert php use statement
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
