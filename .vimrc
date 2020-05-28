syntax on "enable highlighting
set number "enable line number

"identation
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

"clipboard stuff
set pastetoggle=<F2> "enable paste mode
set clipboard=unnamedplus

"enable mouse support
set mouse=a

"git-gutter configurations
let g:gitgutter_max_signs = 1500

"colorscheme stuff
let g:solarized_termcolors=256
set t_Co=256
set background=dark
colorscheme minimalist 

let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

function! NERDTreeToggleInCurDir()
  let current_dir = expand('%:p')
  execute ":NERDTreeToggle ".current_dir
endfunction

"toggle nerdtree filesystem in current folder with <C-B>
nmap <C-B> :call NERDTreeToggleInCurDir()<CR>

"ctrlp configurations"
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_map = '<F1>'
let g:ctrlp_cmd = 'CtrlP'

"tab navegation key mappings
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

"get current file specific formatter
function! Get_default_formatter_command()
  let current_filetype = &filetype 
  let formatters = { 
   \'cs': ':OmniSharpCodeFormat',
   \'rs': ':RustFmt',
   \'javascript': ':PrettierAsync',
   \'typescript': ':PrettierAsync',
   \'js': ':PrettierAsync',
   \'ts': ':PrettierAsync',
   \'json': ':PrettierAsync',
   \'vue': ':PrettierAsync',
   \'jsx': ':PrettierAsync',
   \'tsx': ':PrettierAsync'
   \}
  if has_key(formatters, current_filetype)
    execute formatters[current_filetype]
  else
    echo "No installed formatter for this type of file"
  endif
  
endfunction


"map coc prettier format to <C-F>
nmap <C-F> :call Get_default_formatter_command() <CR>

"enable format on save of rust code
let g:rustfmt_autosave = 1

"Plugin Manager
call plug#begin('~/.vim/plugged')

"FileSystem Plugins"
Plug 'scrooloose/nerdtree'

Plug 'ctrlpvim/ctrlp.vim' "Add support to navigate through files when press <C-p>

"Languages pack
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'OmniSharp/omnisharp-vim'
Plug 'Quramy/tsuquyomi' "typescript helper
Plug 'leafgarland/typescript-vim' " Typescript highlighter

"git related stuff
Plug 'airblade/vim-gitgutter'

"Bottom line 
Plug 'vim-airline/vim-airline'

"formating
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

"Color themes
Plug 'dikiaap/minimalist'
Plug 'altercation/solarized'

"Code typing helpers
Plug 'jiangmiao/auto-pairs'

call plug#end()
