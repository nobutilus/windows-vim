set noerrorbells
set number
set encoding=utf-8
set fileencoding=utf-8



let mapleader = " "

call plug#begin('~/.vim/plugged')

" goプラグイン
Plug 'fatih/vim-go', { 'for': 'go', 'on': ['GoDef', 'GoBuild', 'GoTest', 'GoRun', 'GoFmt'] }

" 自動補完
Plug 'neoclide/coc.nvim', {'branch': 'release', 'on':[]}
" coc.nvim用のyaml補完とlint
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
" coc-prettierプラグイン
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}

" 括弧とクオーテーションの自動補完
Plug 'jiangmiao/auto-pairs'

" surround.vimプラグイン
Plug 'tpope/vim-surround'

" fzfとfzf.vimプラグイン
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" yamlファイルのシンタックスハイライトとインデント
Plug 'stephpy/vim-yaml'

" 文法チェックのためのプラグイン
Plug 'rhysd/vim-grammarous'

" markdown support
Plug 'tpope/vim-markdown', {'for': 'markdown'}

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for':'markdown' }

Plug 'liuchengxu/vim-which-key'

" on-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
autocmd User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

Plug 'chiendo97/intellij.vim'

Plug 'itchyny/lightline.vim'

Plug 'shmup/vim-sql-syntax', {'for':'sql'}

" vim-gitgutterをインストール
Plug 'airblade/vim-gitgutter'


call plug#end()

" vim-goの設定
let g:go_fmt_command = "goimports"  " 保存時にgoimportsを実行
let g:go_def_mode = 'gopls'  " goplsを使用して定義へジャンプ
let g:go_info_mode = 'gopls'  " goplsを使用して情報を表示

set background=dark
colorscheme intellij

set laststatus=2


let g:lightline = {
      \ 'colorscheme': 'intellij',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitivehead'
      \ },
      \ }

" cocの設定
let g:coc_global_extensions = ['coc-go', 'coc-yaml', 'coc-prettier', 'coc-spell-checker']

" 自動補完のキーバインド
inoremap <silent><expr> <c-cr> coc#refresh()


" tabとshift-tabで補完候補を移動
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"


" 定義へジャンプ
nmap <silent> gd <Plug>(coc-definition)

" 形式チェック
autocmd bufwritepre *.go :silent! lua vim.lsp.buf.formatting_sync(nil, 1000)

" yamlファイル保存時にprettierでフォーマット
autocmd bufwritepre *.yaml,*.yml :CocCommand prettier.formatfile

" shift + kでコードの説明を表示
augroup go
  autocmd!
  autocmd filetype go nmap <buffer> <S-K> :GoDoc<CR>
augroup end

" fzf.vimのキーマッピング
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fg :GFiles<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fh :Helptags<cr>

" leaderキーを2回押してfzfファイル検索を起動
nnoremap <leader><leader> :Files<cr>

" ハイライトをオフにするキーマッピング
nnoremap <leader>h :nohlsearch<cr>

" coc.nvimの補完メニューのナビゲーションをtabとshift+tabに変更
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"


inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"




" custom commands or mappings (optional)
autocmd filetype markdown nnoremap <leader>mp :markdownpreview<cr>

nnoremap <silent><leader> :WhichKey '<Space>'<cr>

" by default timeoutlen is 1000 ms
set timeoutlen=500

" enable which-key
let g:which_key_map = {}
let g:which_key_map['w'] = {
      \ 'name' : 'windows' ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ }
let g:which_key_map['g'] = {
	\ 'name': 'Go',
	\ 'b': ['GoBuild', 'Build'],
	\ 't': ['GoTest', 'Test'],
	\ 'r': ['GoRun', 'Run'],
	\ 'i': ['GoImport', 'Import'],
	\ 's': ['GoDef', 'Definition'],
	\ }
let g:which_key_map['c'] = {
        \ 'name': 'Coc',
        \ 'a': ['<Plug>(coc-action)', 'Action'],
        \ 'd': ['CocDiagnostics', 'Diagnostics'],
        \ 'r': ['<Plug>(coc-rename)', 'Rename'],
        \ }

let g:which_key_map['l'] = {
        \ 'name': 'Lazy',
        \ 'g': [':!lazygit', 'git'],
        \ 'd': ['lazydocker', 'docker'],
        \ }


let g:which_key_map['b'] = {
        \ 'name': 'buffer',
        \ 'p': [':bprev ', 'previous'],
        \ 'n': [':bnext', 'next'],
        \ }

let g:which_key_map['t'] = {
        \ 'name': 'tab',
        \ 'p': [':tabprevious', 'previous'],
        \ 'n': [':tabnext', 'next'],
        \ 'c': [':tabnew', 'create new one'],
        \ }

let g:which_key_map.e = 'Explore Files'

" <leader>e にnetrwを開くコマンドをマッピングする
nnoremap <leader>e :Explore<CR>
"augroup Yank
"  au!
"  autocmd TextYankPost * :call system('win32yank.exe', @")
"augroup END
"
if executable('win32yank.exe')
  au TextYankPost * call system('win32yank.exe -i &', @")
    function Paste(p)
      let sysclip=system('win32yank.exe -o')
        if sysclip != @"
	  let @"=sysclip
	endif
	return a:p
  endfunction
endif

nnoremap v <c-q> 
" Vimの起動後に一定時間後にvim-goをロード
autocmd VimEnter * call timer_start(2000, { -> execute('call plug#load("vim-go")') })
" Vimの起動後2秒でcoc.nvimをロード
autocmd VimEnter * call timer_start(2000, { -> execute('call plug#load("coc.nvim")') })

" vim-goの自動型情報表示を遅延して有効化
autocmd VimEnter * call timer_start(3000, { -> execute('let g:go_auto_type_info = 1') })
" signcolumnを常に表示
set signcolumn=yes
