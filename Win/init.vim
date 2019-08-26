syntax on
set showmatch
set nu
set autoindent
set cindent
set wildmenu
colorscheme inkstained
"自动匹配括号
inoremap ' ''<ESC>i
inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap [ []<ESC>i
inoremap { {<CR>}<ESC>O
map S :w<CR>
map Q :q<CR>
map sr :set splitright<CR>:vsplit<CR>
map sl :set nosplitright<CR>:vsplit<CR>
map su :set nosplitbelow<CR>:split<CR>
map sb :set splitbelow<CR>:split<CR>
map <C-l> <C-w>l
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-x> ggVG"+yy<CR>
map re :call SetTitle()<CR>
map <C-d> :?*A<CR>6dd<CR>:?freopen<CR>dd
map tu :tabe<CR>
map tn :-tabnext<CR>
map ti :+tabnext<CR>
map <C-up> :res +5<CR>
map <C-down> :res -5<CR>
map <C-left> :vertical resize-5<CR>
map <C-right> :vertical resze+5<CR>

func SkipPair()  
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'  
            return "\<ESC>la"  
    else  
        return "\t"  
    endif  
endfunc  

" 将tab键绑定为跳出括号  
inoremap <tab> <c-r>=SkipPair()<cr>

"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu

set showcmd "输出的命令显示出来

autocmd InsertLeave * se nocul " 用浅色高亮当前行
autocmd InsertEnter * se cul " 用浅色高亮当前行 

"set foldenable " 允许折叠
"set foldmethod=manual " 手动折叠 

set nocompatible "去掉讨厌的有关vi一致性模式,避免以前版本的一些bug和局限 

"去空行
nnoremap <F1> :g/^/s*$/d<CR> 

"代码补全
set completeopt=preview,menu 


" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
set noexpandtab
" 在行和段开始处使用制表符
set smarttab

"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch

set gdefault "行内替换
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,utf-16,big5,euc-jp,latin1 "

"编码设置

set langmenu=zn_CN.UTF-8
set helplang=cn  "语言设置
set tabstop=4 "设置tab
set shiftwidth=4 "设置缩进
set ruler "在编辑过程中，在右下角显示光标位置的状态行

set laststatus=1  "总是显示状态行

set showcmd "在状态行显示目前所执行的命令，未完成的指令片段也会显示出来

set scrolloff=3 "光标移动到buffer的顶部和底部时保持3行的距离"""""""


set showmatch
set selection=exclusive
set laststatus=2
set wildmenu  "增强模式中的命令行自动完成操作

set linespace=2 "字符间插入的像素行数目

filetype plugin indent on
"分为三部分命令:file on,file plugin on,file indent on 分别是自动识别文件类型, 用用文件类型脚本,使用缩进定义文件""]""

filetype on "打开文件类型检测功能

set completeopt=noinsert,menuone,noselect
" enable ncm2 for all buffers
func SetTitle()
    call setline(1,"/*A**********************************************************************")
    call append(line("."), "    > File Name: ".expand("%")) 
    call append(line(".")+1, "    > Author: GyxChen") 
    call append(line(".")+2, "    > Mail: 3370436119@qq.com ") 
    call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
    call append(line(".")+4, "************************************************************************/") 
        call append(line(".")+5, "#include<bits/stdc++.h>")
		call append(line(".")+6, "using namespace std;")
		call append(line(".")+7,"int main()")
		call append(line(".")+8, "{")
		call append(line(".")+9, "\tfreopen(\"in.txt\",\"r\",stdin);")
		call append(line(".")+10,"}")
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
	endif
endfunc
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufNewFile *.cpp,*.[ch] exec ":call SetTitle()"
autocmd BufNewFile * normal GO
"C,C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %>"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %.o"
        exec "!./%.o"
		exec "echo \"====\""
    endif    
endfunc

"Navgation
map <F3> :NERDTreeToggle<CR>

"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
exec "w"
exec "!g++ % -g -o %<"
exec "!gdb ./%<"
endfunc
"
set tags=/home/lsh/files/tags
let Tlist_Auto_Open = 1
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Exit_OnlyWindow = 1
let g:ncm2_pyclang#library_path = '/usr/lib/libclang.so.8'
""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'yuttie/inkstained-vim'
" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-pyclang'
call plug#end()
