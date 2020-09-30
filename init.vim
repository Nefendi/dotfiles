""""""""""""""""""""""""""""""""""""""" vim-plug and plugins """""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/mru.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'joshdick/onedark.vim'
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'cohama/lexima.vim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'cdelledonne/vim-cmake'
Plug 'rhysd/vim-clang-format'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'aklt/plantuml-syntax'
Plug 'tpope/vim-fugitive'
Plug 'numirias/semshi'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'maximbaz/lightline-ale'

call plug#end()

""""""""""""""""""""""""""""""""""""""" Basic configuration """""""""""""""""""""""""""""""""""""""
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set number
set completeopt=preview,menu,longest
set shiftwidth=4
set mouse=a
set textwidth=0
set wrapmargin=0
set nowrap
set noshowmode
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Signcolumn produces an error in neovim
"set signcolumn=number
:colorscheme onedark

""""""""""""""""""""""""""""""""""""""" Variables """""""""""""""""""""""""""""""""""""""
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
	    \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
			\			  [ 'lineinfo' ],
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

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf00d "
let g:lightline#ale#indicator_ok = "\uf00c "


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
							  \ 'coc-snippets',
							  \ 'coc-fzf-preview'
							\ ]

let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

let g:ale_linters = {
      \   'python': [ 'flake8', 'pylint' ]
	  \ }

let g:ale_fixers = {
	  \   '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
	  \ }

let g:ale_fix_on_save = 1

let b:ale_warn_about_trailing_whitespace = 0

let g:ale_sign_error = "\uf00d"
let g:ale_sign_warning = "\uf071"
let g:ale_sign_info = "\uf129"

highlight ALEWarningSign ctermfg=DarkYellow
highlight ALEInfoSign ctermfg=Green

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
autocmd Filetype cpp let g:clang_format#style_options = { "BasedOnStyle" : "Google"}

"""""""""""""""""""""""""""""""""""""""""""""""""""" Functions """"""""""""""""""""""""""""""""""""""""""""""""""""
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

""""""""""""""""""""""""""""""""""""""" Commands """""""""""""""""""""""""""""""""""""""

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Rust
autocmd Filetype rs set tabstop=8 softtabstop=4 expandtab shiftwidth=4 smarttab

" Python
autocmd Filetype py match MatchParen '\%>79v.\+'
autocmd Filetype py set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

" C++ and C
autocmd Filetype cpp match MatchParen '\%>79v.\+'
autocmd Filetype cpp set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype cc set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype c set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
autocmd Filetype h set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype hpp set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

:autocmd TermOpen :set nonumber

""""""""""""""""""""""""""""""""""""""" Mappings """""""""""""""""""""""""""""""""""""""

" Highlight words on double clicking
:noremap <2-LeftMouse> * <c-o>
:inoremap <2-LeftMouse> <c-[>* <c-o> i

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Clangd
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
xmap <leader>u <Plug>(coc-format-selected)
nmap <leader>u <Plug>(coc-format-selected)

" Use \d to show documentation in preview window
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@<CR>

" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Coc-Explorer
:nmap <Space>e :CocCommand explorer<CR>

" Fzf
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
nnoremap <silent> <space>a       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <space>x       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <space>l       :<C-u>CocFzfList location<CR>
nnoremap <silent> <space>o       :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>p       :<C-u>CocFzfListResume<CR>

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>

" Inside terminal-mode
:tnoremap <C-[> <C-\><C-n>
