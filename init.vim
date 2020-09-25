"vim-plug
call plug#begin('~/.local/share/nvim/plugged')

"Everyday
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/mru.vim'
Plug 'joshdick/onedark.vim'
Plug 'chrisbra/csv.vim'

:set spelllang=en_us,pl
:set spell

"Highlight words on double clicking
:noremap <2-LeftMouse> * <c-o>
:inoremap <2-LeftMouse> <c-[>* <c-o> i

"Fileview
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
let NERDTreeShowHidden = 1

"Completion
Plug 'cohama/lexima.vim'
Plug 'ycm-core/YouCompleteMe', { 'do': '/usr/local/bin/python3.8 ./install.py --all' }
Plug 'rdnetto/YCM-Generator'
let g:ycm_server_python_interpreter = '/usr/local/bin/python3.8'
let g:python3_host_prog = '/usr/local/bin/python3.8'
let g:ycm_always_populate_location_list = 1
let g:ycm_clangd_args = ['-cross-file-rename']
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']

nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>r :YcmCompleter RefactorRename<Space>
nnoremap <leader><leader> :YcmCompleter GoToReferences<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>
nnoremap <leader>f :YcmCompleter FixIt<CR>

"Rust
autocmd Filetype rs set tabstop=8 softtabstop=4 expandtab shiftwidth=4 smarttab

"Python
Plug 'davidhalter/jedi-vim'
autocmd Filetype py match MatchParen '\%>79v.\+'
autocmd Filetype py set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

"C++
Plug 'octol/vim-cpp-enhanced-highlight'
autocmd Filetype cpp match MatchParen '\%>79v.\+'
autocmd Filetype cpp set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype hpp set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
Plug 'rhysd/vim-clang-format'
let g:clang_format#detect_style_file=1
let g:clang_format#auto_format_on_insert_leave=1
autocmd Filetype cpp let g:clang_format#style_options = { "BasedOnStyle" : "Google"}

"C
autocmd Filetype c set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

"Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"UML
Plug 'aklt/plantuml-syntax'

"Git
Plug 'tpope/vim-fugitive'

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

" Check this amazing post
" https://vi.stackexchange.com/questions/22398/disable-lightline-on-nerdtree
augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu
