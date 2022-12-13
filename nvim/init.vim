set tabstop=4
set shiftwidth=4
set expandtab
" set smarttab
" set hlsearch

" Prevent indentation on # comment
set cindent cinkeys-=0#
" Disablel automatic omment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Turn off search loop
set nowrapscan

" Turn off tabs for makefiles
autocmd FileType make setlocal noexpandtab

" Insert newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Use system clipboard
set clipboard=unnamed

set exrc


" Hit F5 to trim trailing whitespaces
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" Hit to highlight the current line
:nnoremap <C-L> :set cursorline! <CR>

" To see code below during search
set scrolloff=3


" Highlight trailing spaces
if has("syntax") && (&t_Co > 2 || has("gui_running"))
  syntax on
  function! ActivateInvisibleCharIndicator()
  	syntax match TrailingSpace "[ \t]\+$" display containedin=ALL
  	highlight TrailingSpace ctermbg=Red
  endf
  autocmd BufNewFile,BufRead * call ActivateInvisibleCharIndicator()
endif
" Show tabs, trailing whitespace, and continued lines visually
set list listchars=tab:»·,trail:·,extends:…


" Press Space to remove highlighting of search results after replace
:noremap <silent> <Space> :silent noh<Bar>echo<CR>


" python goto next/previous member with [[ and ]]
autocmd FileType python nnoremap <buffer> [[ ?^class\\|^\s*def\\|^\s*async\s*def<CR>
autocmd FileType python nnoremap <buffer> ]] /^class\\|^\s*def\\|^\s*async\s*def<CR>
