"vim-plug
call plug#begin('~/.local/share/nvim/plugged')

"Everyday
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/mru.vim'
Plug 'joshdick/onedark.vim'
Plug 'chrisbra/csv.vim'

let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

"Highlight words on double clicking
:noremap <2-LeftMouse> * <c-o>
:inoremap <2-LeftMouse> <c-[>* <c-o> i

"Completion
Plug 'cohama/lexima.vim'

"Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 'coc-spell-checker',
							  \ 'coc-cspell-dicts',
							  \ 'coc-explorer',
							  \ 'coc-actions',
							  \ 'coc-sh',
							  \ 'coc-json',
							  \ 'coc-cmake',
							  \ 'coc-clangd',
							  \ 'coc-python',
							  \ 'coc-highlight',
							  \ 'coc-markdownlint',
							  \ 'coc-rust-analyzer',
							  \ 'coc-snippets'
							\ ]

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Clangd
Plug 'jackguo380/vim-lsp-cxx-highlight'
nmap <silent> <leader>h :call CocAction('runCommand', 'clangd.switchSourceHeader')<CR>
nmap <silent> <leader>s :call CocAction('runCommand', 'clangd.symbolInfo')<CR>

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>g <Plug>(coc-definition)
nmap <silent> <leader>t <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader><leader> <Plug>(coc-references)

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Use \d to show documentation in preview window
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>x  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"Coc-Explorer
:nmap <Space>e :CocCommand explorer<CR>

"Rust
autocmd Filetype rs set tabstop=8 softtabstop=4 expandtab shiftwidth=4 smarttab

"Python
autocmd Filetype py match MatchParen '\%>79v.\+'
autocmd Filetype py set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

"CMake
Plug 'cdelledonne/vim-cmake'

"C++ and C
autocmd Filetype cpp match MatchParen '\%>79v.\+'
autocmd Filetype cpp set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype cc set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype c set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
autocmd Filetype h set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype hpp set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
Plug 'rhysd/vim-clang-format'
let g:clang_format#detect_style_file=1
let g:clang_format#auto_format=0
autocmd Filetype cpp let g:clang_format#style_options = { "BasedOnStyle" : "Google"}

function! FormatCppOnSave()
  :silent !{git status}
  if v:shell_error != 0
	:ClangFormat
  else
    let l:formatdiff = 1
  	:silent !{git clang-format --force --quiet}
  	:e
  endif
endfunction

autocmd BufWritePost *.h,.*hpp,*.cc,*.cpp,*.c call FormatCppOnSave()


"Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"UML
Plug 'aklt/plantuml-syntax'

"Git
Plug 'tpope/vim-fugitive'

Plug 'ryanoasis/vim-devicons'

call plug#end()

"Inside terminal-mode
:tnoremap <C-[> <C-\><C-n>
:autocmd TermOpen :set nonumber

"All the other stuff
set number
set completeopt=preview,menu,longest
set shiftwidth=4
set mouse=a
set textwidth=0
set wrapmargin=0
set nowrap
:colorscheme onedark

"lightline
set noshowmode
let g:lightline = {
	    \ 'colorscheme': 'onedark',
            \ 'component': {
	    \    'lineinfo': '%3l:%-2c%<',
            \    'percent': '%3p%%%<',
            \    'fileformat': '%{&ff}%<',
            \    'fileencoding': '%{&fenc!=#""?&fenc:&enc}%<',
            \    'filetype': '%{&ft!=#""?&ft:"no ft"}%<'
            \   },
	    \ 'active': {
	    \   'left': [ [ 'mode', 'paste' ],
	    \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ],
	    \   'right': [ [ 'lineinfo' ],
            \             [ 'percent' ],
            \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
	    \ },
	    \ 'inactive': {
	    \ 'left': [ ['relativepath'] ],
	    \ 'right': []
	    \ },
	    \ 'component_function': {
	    \      'gitbranch': 'FugitiveHead',
	    \ },
	    \ }
