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
set scrolloff=2


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

" Shortcut Ctrl-s for saving
nnoremap <c-s> :w<cr>

source ~/workspace/github/my/configs/nvim/packer/nvim.in

lua <<EOF
-- example of setup of packer plugin
-- require("mason").setup()
EOF

" Proper highlighting of comments for jsonc
autocmd FileType json syntax match Comment +\/\/.\+$+

call plug#begin()
" Plug 'sheerun/vim-polyglot' -- This plugin makes nvim ignore swp files - no prompt for file restore
Plug 'plasticboy/vim-markdown'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

" plasticboy/vim-markdown settings
syntax enable
filetype plugin indent on
let g:vim_markdown_folding_disabled = 1

" https://stackoverflow.com/questions/62435926/coc-nvim-how-to-disable-auto-complete-suggestions-in-markdown-files
autocmd FileType markdown let b:coc_suggest_disable = 1

" coc
" Press Enter to confirm completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Map for Ukrainian language
set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\\;,
  \є',ґ\\,яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,,ЙQ,ЦW,УE,КR,ЕT,НY,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,
  \ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\:,Є\\",Ґ\|,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\\<,Ю>,№#

set termguicolors
hi Normal ctermbg=NONE guibg=NONE
