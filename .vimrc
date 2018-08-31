if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source &MYVIMRC
endif
autocmd BufWritePost $MYVIMRC source $MYVIMRC	"let configuration work right now
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o 		" console line complete

filetype off
filetype plugin indent on

set rtp+=~/.vim/autoload/plug.vim
set nocompatible
" open quick search
set incsearch
set ignorecase
set nocompatible
set wildmenu

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/neocomplete.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe',{'for':'c'}
Plug 'tpope/vim-commentary'
Plug 'ianva/vim-youdao-translater'

" c / cpp
Plug 'derekwyatt/vim-fswitch',{'for':'c'}
Plug 'derekwyatt/vim-protodef',{'for':'c'}
Plug 'vim-scripts/c.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'rhysd/vim-clang-format'
call plug#end()

" fullscreen
fun! ToggleFullscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
map <silent> <F11> :call ToggleFullscreen()<CR>

" ctags config
set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta


let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ }
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
let g:ycm_complete_in_comments=1
let g:ycm_confirm_extra_conf=0
let g:ycm_min_num_of_chars_for_completion=1

"let g:clang_format#auto_format_on_insert_leave=1


let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/thrid_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
let g:protodefprotogetter='~/.vim/plugged/vim-protodef/pullproto.pl'
let g:disable_protodef_sorting=1

let mapleader=";"
nnoremap <S-k> <Esc>:tabnext<CR>
nnoremap <S-j> <Esc>:tabprevious<CR>
"inoremap j <Down>
"inoremap k <Up>
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"nnoremap <C-j> <Down>
"nnoremap <C-k> <Up>
