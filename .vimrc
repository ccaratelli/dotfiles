" ~/.vimrc (configuration file for vim only)
" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	if $USER != ''
	    let login = $USER
	elseif $LOGNAME != ''
	    let login = $LOGNAME
	else
	    let login = 'unknown'
	endif
	let newline = stridx(login, "\n")
	if newline != -1
	    let login = strpart(login, 0, newline)
	endif
	if $HOSTNAME != ''
	    let hostname = $HOSTNAME
	else
	    let hostname = system('hostname -f')
	    if v:shell_error
		let hostname = 'localhost'
	    endif
	endif
	let newline = stridx(hostname, "\n")
	if newline != -1
	    let hostname = strpart(hostname, 0, newline)
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
	setf spec
endfunction
autocmd BufNewFile	*.spec	call SKEL_spec()

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
 set showcmd

" Folding Stuffs
set foldmethod=marker

filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent
" Spaces are better than a tab character
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

set number
set ignorecase
set smartcase

inoremap jj <Esc>
nnoremap JJJJ <Nop>

set incsearch
set hlsearch

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

nnoremap <F3> :set number!<CR>

nnoremap ; :

set t_Co=256
hi LineNr ctermfg=black ctermbg=lightgrey

filetype plugin indent on
syntax on
" ~/.vimrc ends here

nnoremap ,p :1/&cell<CR>nj2yj5jp3j2dj:x<CR>

au FileType cp2k setlocal foldlevel=99 foldmethod=indent
nnoremap ,l   :w<CR>:! python %<CR>
