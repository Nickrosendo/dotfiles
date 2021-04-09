" =============================================================================
" # Editor settings
" =============================================================================

syntax on "enable highlighting
set number "enable line number
set relativenumber " line numbers relative to current line
set encoding=utf-8
filetype plugin indent on " allow auto filtype plugin and indentation configuration
set hidden
set nobackup
set nowritebackup
set cursorline " Enable highlight current cursor line

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"configure the amount of lines a commands display height
set cmdheight=1

"identation
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set scrolloff=2
set nowrap
set showtabline=2 "allways show tab name
set nojoinspaces

"Pane split options
set splitright
set splitbelow

"print options
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter

"clipboard stuff
set pastetoggle=<F2> "enable paste mode
set clipboard=unnamedplus

"enable mouse support
set mouse=a

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" coc config
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json', 
  \ 'coc-vetur',
  \ 'coc-diagnostic',
  \ 'coc-prettier',
  \ 'coc-html',
  \ 'coc-css'
  \ ]

"disable coc vim update warning
let g:coc_disable_startup_warning = 1

"git-gutter configurations
let g:gitgutter_max_signs = 500

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" =============================================================================
" # Visual settings
" =============================================================================

"colorscheme stuff
set t_Co=256
set background=dark
colorscheme gruvbox

"highlight Normal cterm=bold ctermfg=15 ctermbg=0" Change background and foreground color
"
"gruvbox configurations
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
set termguicolors


hi Normal guibg=NONE ctermbg=NONE

"vim-airline configurations
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" =============================================================================
" # Util Functions 
" =============================================================================
" 

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

"get current file specific formatter
function! Get_default_formatter_command()
  let current_filetype = &filetype 
  let formatters = { 
   \'cs': ':OmniSharpCodeFormat',
   \'rs': ':RustFmt',
   \'rust': ':RustFmt',
   \'javascript': ':PrettierAsync',
   \'typescript': ':PrettierAsync',
   \'typescriptreact': ':PrettierAsync',
   \'javascriptreact': ':PrettierAsync',
   \'js': ':PrettierAsync',
   \'ts': ':PrettierAsync',
   \'json': ':PrettierAsync',
   \'vue': ':PrettierAsync',
   \'jsx': ':PrettierAsync',
   \'tsx': ':PrettierAsync',
   \'html': ':PrettierAsync',
   \'css': ':PrettierAsync',
   \'scss': ':PrettierAsync',
   \}
  if has_key(formatters, current_filetype)
    execute formatters[current_filetype]
  else
    echo "No installed formatter for this type of file"
  endif
  
endfunction

function! NERDTreeToggleInCurDir()
  let current_dir = expand('%:p')
  execute ":NERDTreeToggle ".current_dir
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" =============================================================================
" # Remappings 
" =============================================================================
" 

" map leader to space
let mapleader = "\<Space>"

"map coc prettier format to <C-F>
nmap <C-F> :call Get_default_formatter_command() <CR>

" toggle nerdtree filesystem in current folder with <C-B>
" nmap <C-B> :call NERDTreeToggleInCurDir()<CR>

"tab navegation key mappings
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>


"fzf commands remaps
map <F1> :Ag<CR> 
map <C-B> :Files <CR>
map <C-p> :Buffers<CR>

" Remap <space-tab> to mru buffer switch
nnoremap <leader><tab> :b#<cr>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

"Go To definition remappings
  nmap <buffer> <leader>gd <Plug>(coc-definition)
  nmap <buffer> <leader>gy <Plug>(coc-type-definition)
  nmap <buffer> <leader>gi <Plug>(coc-implementation)
  nmap <buffer> <leader>gr <Plug>(coc-references)

" Remap pane split keybindings to use <leader-w> instead of <C-w>
nnoremap <leader>ws :sp<cr>
nnoremap <leader>wv :vs<cr>

" Remap pane splits moving keybinding to use <leader> key instead of <ctrl>
nnoremap <leader>wh <c-w>h<cr>
nnoremap <leader>wj <c-w>j<cr>
nnoremap <leader>wk <c-w>k<cr>
nnoremap <leader>wl <c-w>l<cr>
nnoremap <leader>wK <c-w>K<cr>
nnoremap <leader>wH <c-w>H<cr>

" vim-maximizer command remap
nnoremap <leader>z :MaximizerToggle<cr>

" =============================================================================
" # Code Formating Settings
" =============================================================================

"enable format on save of rust code
let g:rustfmt_autosave = 1

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

"=============================================================================
" # Plugins 
" =============================================================================

"Plugin Manager
call plug#begin(stdpath('data') . '/plugged')

"FileSystem Plugins"
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Fast Finder for files, buffer ...
Plug 'airblade/vim-rooter' "Set the work directory to the root of the current project

"Multiplexer plugins"
Plug 'szw/vim-maximizer'

"Languages pack
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'OmniSharp/omnisharp-vim'
Plug 'leafgarland/typescript-vim' " Typescript highlighter

" Autocomplete stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"code smells
Plug 'machakann/vim-highlightedyank' "highlight copied content
Plug 'editorconfig/editorconfig-vim'

"git related stuff
Plug 'airblade/vim-gitgutter'

"Bottom line 
Plug 'vim-airline/vim-airline'

"formating
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'tsx', 'typescriptreact', 'javascriptreact'] }

"Color themes
Plug 'dikiaap/minimalist'
Plug 'altercation/solarized'
Plug 'morhetz/gruvbox'
Plug 'ajh17/spacegray.vim'
Plug 'sainnhe/sonokai'

"Code typing helpers

" Code previews
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"FrontEnd helpers
Plug 'ap/vim-css-color'
Plug 'gregsexton/matchtag'

"Line highlighting
Plug 'danilamihailov/beacon.nvim' "Hightlight current line after a jump
Plug 'inside/vim-search-pulse' "Hightlight current line after a search

call plug#end()
