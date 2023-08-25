set runtimepath+=/usr/share/vim/vimfiles
syntax on
set encoding=utf-8
set fileencoding=utf-8
set mouse=a
set clipboard+=unnamedplus
set sw=4
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set cursorline
set smartindent
set number
set rnu
setlocal iskeyword+=-
set complete+=kspell
set completeopt=menuone,longest
set noswapfile
set nobackup
set incsearch
set ignorecase
set splitbelow
set splitright
set termguicolors
set autowrite
set autoread
let g:session_autoload = 'no'
let g:workspace_autosave_always = 1

"poner en todos los documentos para que se aplique el folding
"set foldmethod=manual

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END


"MAPEO BASICO
imap jk <Esc>
let mapleader = " "
nmap <leader>i :source /usr/share/nvim/archlinux.vim<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>ñ :

"MAPEO VENTANAS
nnoremap fl :tabn<CR>
nnoremap fn :tabp<CR>
nnoremap <c-p> :tabnew<CR>

"MAPEO ARBOL DE ARCHIVOS 
nnoremap <C-n> :NERDTreeToggle<CR>

"MAPEO VENTANAS
nnoremap <silent> <left> :vertical resize -5<CR>
nnoremap <silent> <right> :vertical resize +5<CR>
nnoremap <silent> <down> :resize +5<CR>
nnoremap <silent> <up> :resize -5<CR>

nnoremap <leader>v :vsp<CR>
nnoremap <leader>f :sp<CR>

"MAPEO TERMINAL
noremap <c-c> :split<CR>:ter<CR>
tnoremap <c-u>          <C-\><C-n>

"MAPEO BUSQUEDA
nnoremap <leader>o :/

nnoremap <c-i> :VCoolor<CR>

"MAPEO ARCHIVOS
nnoremap <leader>e :Files<CR>

"FUNCION PARA ELIMINA BUFFERS QUE ESTEN VACIOS
function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction

nnoremap <leader>x :call DeleteEmptyBuffers()<CR>

nnoremap <leader>s :w<CR>:split<CR>:resize 1<CR>:ter live-server %:p:h<CR>


"MAPEO TEMAS
call plug#begin('/usr/share/nvim/plugins')

"PLUGIN PARA TEMAS
Plug 'kjwon15/vim-transparent'
Plug 'mcchrish/zenbones.nvim'

"PLUGIN PARA ARBOL DE ARCHIVOS
Plug 'scrooloose/nerdtree'

Plug 'gko/vim-coloresque'
Plug 'preservim/nerdcommenter'
Plug 'lilydjwg/colorizer'

Plug 'KabbAmine/vCoolor.vim'

"PLUGIN PARA MOVER ENTRE VENTANAS
Plug 'christoomey/vim-tmux-navigator'

"PLUGIN PARA AUTO CERRAR PARENTESIS
Plug 'jiangmiao/auto-pairs'
Plug 'yggdroot/indentline'

"PLUGIN PARA AUTOCOMPLETAR
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'thaerkh/vim-workspace'
Plug 'djoshea/vim-autoread'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

Plug 'beauwilliams/statusline.lua'

call plug#end()
set background=dark
colorscheme neobones

"let g:fzf_colors =
            "\ { 'fg':  jj ['fg', 'Number'],
            "\ 'bg':      ['bg', 'Normal'],
            "\ 'hl':      ['fg', 'Comment'],
            "\ 'fg+':     ['fg', 'CursorLine', 'CursorLine', 'CursorLine'],
            "\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            "\ 'hl+':     ['fg', 'Statement'],
            "\ 'info':    ['fg', 'PreProc'],
            "\as ['fg', 'Define'],
            "\ 'prompt':  ['fg', 'MatchParen'],
            "\ 'pointer': ['fg', 'Exception'],
            "\ 'marker':  ['fg', 'Keyword'],
            "\ 'spinner': ['fg', 'Label'],
            "\ 'header':  ['fg', 'Comment'] }


inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

