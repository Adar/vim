" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set encoding=utf-8
set fileencoding=
setglobal fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
" set termencoding=utf-8

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set formatoptions=qroct
set autoindent
set bg=light
"set nonumber number
set noswf
colorscheme icansee

let php_sql_query = 1
let php_htmlInStrings = 0
let php_baselib = 1
let php_parent_error_close = 1
let php_parent_error_open = 1
let php_sync_method = 1

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" smarty syntax-file
au BufRead,BufNewFile *.tpl set filetype=smarty 
" set makeprg=php5 for .php-files
au BufRead,BufNewFile *.php set makeprg=/usr/bin/php5\ -l\ %
" set php_doc for .php-files
au BufRead,BufNewFile *.php set keywordprg=/home/$USER/.vim/.php_doc 


" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
endif " has("autocmd")
    
nmap zz zo
nmap zt zc

map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr> 
map <F8> <Esc>:VSTreeExplore<Cr>

" Mappings
nmap class :call InsertClass()<CR>
nmap container :call InsertContainer()<CR>
nmap factory :call InsertFactory()<CR>
nmap interface :call InsertInterface()<CR>
imap ( (<ESC>:call TryMethodDocblock()<CR>a

nmap cc :HideComments<CR>
nmap cs :ShowComments<CR>

nmap ag :InsertGetterOnly<CR>
nmap as :InsertSetterOnly<CR>
nmap ab :InsertBothGetterSetter<CR>

nmap ci :VCSCommit<CR>
nmap up :VCSUpdate<CR>
nmap diff :VCSDiff<CR>

syntax on

iab     _ts     <C-R>=strftime("%Y%m%d %H:%M")<CR>
iab     _td     <C-R>=strftime("%Y%m%d")<CR>
iab     _tsu    <C-R>=strftime("%Y%m%d %H:%M")<CR><CR><ESC>!!echo -n "$LOGNAME"<CR><ESC>kJA
iab     _tsx    <C-R>=strftime("%Y%m%d %H:%M")<CR>_<CR><ESC>!!echo -n "$LOGNAME"<CR><ESC>kJxA
iab     _tdu    <C-R>=strftime("%Y%m%d")<CR><CR><ESC>!!echo -n "$LOGNAME"<CR><ESC>kJA
iab     _phdr   /**<CR>filebasierte Dokumentation<CR><CR>@package <CR>@author Christian Senkowski <c.senkowski@kon.de><CR>@since <C-R>=strftime("%Y%m%d %H:%M")<CR><CR><CR>@version<CR>/<ESC>kkkkkk$27h
iab     _dhdr   /**<CR>DEFINE<CR><CR>@author Christian Senkowski <c.senkowski@kon.de><CR>@since <C-R>=strftime("%Y%m%d %H:%M")<CR><CR>/<ESC>kkkk$6h
iab     _ghdr   /**<CR>GLOBAL<CR><CR>@author Christian Senkowski <c.senkowski@kon.de><CR>@since <C-R>=strftime("%Y%m%d %H:%M")<CR><CR>/<ESC>kkkk$6h
iab     _chdr   /**<CR>Klassendefinition<CR><CR>@package<CR>@subpackage<CR>@author Christian Senkowski <c.senkowski@kon.de><CR>@since <C-R>=strftime("%Y%m%d %H:%M")<CR><CR>/<ESC>kkkk$10h
iab     _mhdr   /**<CR>Klassenmethode<CR><CR>@param<CR>@return<CR>@author Christian Senkowski <c.senkowski@kon.de><CR>@since <C-R>=strftime("%Y%m%d %H:%M")<CR><CR>/<ESC>kkkkkk$14h
iab     _ahdr   /**<CR>Klassenattribut<CR>@var<CR><CR>/<ESC>kkkkk$15h         
iab     _fhdr   /**<CR>funktionsbasierte Dokumentation<CR><CR>@param<CR>@return<CR>@author Christian Senkowski <c.senkowski@kon.de><CR>@since <C-R>=strftime("%Y%m%d %H:%M")<CR><CR>/<ESC>kkkkkk$31h
iab     _todo   # @todo (chris) :<ESC>
iab     _uuml   &#252;<ESC>
iab     _auml   &#228;<ESC>
iab     _ouml   &#246;<ESC>
iab     _szlig  &#223;<ESC>
iab     _Uuml   &#220;<ESC>
iab     _Auml   &#196;<ESC>
iab     _Ouml   &#214;<ESC>
iab     _nbsp   &#160;<ESC>

source ~/.vim/ftplugin/php_template.vim
