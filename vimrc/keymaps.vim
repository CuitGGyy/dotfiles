"==============================================================================
"
" keymaps.vim - 按键功能绑定映射
"
" 依赖终端或系统的键码识别, 可结合键盘键位布局及键码识别情况予以修改
"
" Created by skywind on 2018/05/30
" Last Modified: 2023/02/21 06:01:30
"
"==============================================================================

" vim: set ts=4 sw=4 tw=78 noet :


"------------------------------------------------------------------------------
" 设定 Vim 的 <leader> 键位
"------------------------------------------------------------------------------
let mapleader="\\"
let g:mapleader="\\"


"------------------------------------------------------------------------------
" Vim 常用功能键位
"------------------------------------------------------------------------------

" 快速保存
"nnoremap <leader>w :w!<cr>

" sudo 权限快速保存
"command W w !sudo tee % > /dev/null
"
" 全部保存并退出
"noremap <silent>Q :<c-u>confirm quitall<cr>

" 在当前缓冲区打开目录
"noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" 关闭高亮显示
nnoremap <silent><leader><space> :nohl<cr>

" 当文件编码格式错乱时，去除格式文件中的 ^M
nnoremap <leader><cr> mmHmt:%s/<c-v><cr>//ge<cr>'tzt'm

" PASTE 粘贴模式开关键位
"noremap <silent><s-f1> :set invpaste!<cr>

" 相对行号开关功能及键位
"noremap <silent><s-f4> :set relativenumber!<cr>


"------------------------------------------------------------------------------
" NORMAL 普通模式下使用 EMACS 移动光标键位
"------------------------------------------------------------------------------
nnoremap <c-h> <left>
nnoremap <c-j> <down>
nnoremap <c-k> <up>
nnoremap <c-l> <right>
nnoremap <c-a> <home>
nnoremap <c-e> <end>
nnoremap <c-d> <del>


"------------------------------------------------------------------------------
" VISUAL 视图模式下使用 EMACS 移动光标键位
"------------------------------------------------------------------------------
vnoremap <c-h> <left>
vnoremap <c-j> <down>
vnoremap <c-k> <up>
vnoremap <c-l> <right>
vnoremap <c-a> <home>
vnoremap <c-e> <end>
vnoremap <c-d> <del>


"------------------------------------------------------------------------------
" INSERT 插入模式下使用 EMACS 移动光标键位
"------------------------------------------------------------------------------
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>


"------------------------------------------------------------------------------
" COMMAND 命令模式下使用 EMACS 移动光标键位
"------------------------------------------------------------------------------
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-d> <del>


"------------------------------------------------------------------------------
" VISUAL 视图模式下搜索选定内容
"------------------------------------------------------------------------------

"function! CmdLine(str)
"    call feedkeys(":" . a:str)
"endfunction

"function! VisualSelection(direction, extra_filter) range
"    let l:saved_reg = @"
"    execute "normal! vgvy"

"    let l:pattern = escape(@", "\\/.*'$^~[]")
"    let l:pattern = substitute(l:pattern, "\n$", "", "")

"    if a:direction == 'gv'
"        call CmdLine("Ack '" . l:pattern . "' " )
"    elseif a:direction == 'replace'
"        call CmdLine("%s" . '/'. l:pattern . '/')
"    endif

"    let @/ = l:pattern
"    let @" = l:saved_reg
"endfunction

" VISUAL 视图模式按下 * 或 # 键，搜索当前选定内容
"vnoremap <silent> * :<c-v>call VisualSelection('', '')<cr>/<c-r>=@/<cr><cr>
"vnoremap <silent> # :<c-v>call VisualSelection('', '')<cr>?<c-r>=@/<cr><cr>


"------------------------------------------------------------------------------
" <leader>+数字键 切换 Tab
"------------------------------------------------------------------------------
noremap <silent><leader>1 1gt<cr>
noremap <silent><leader>2 2gt<cr>
noremap <silent><leader>3 3gt<cr>
noremap <silent><leader>4 4gt<cr>
noremap <silent><leader>5 5gt<cr>
noremap <silent><leader>6 6gt<cr>
noremap <silent><leader>7 7gt<cr>
noremap <silent><leader>8 8gt<cr>
noremap <silent><leader>9 9gt<cr>
noremap <silent><leader>0 10gt<cr>


"------------------------------------------------------------------------------
" <Tab>+数字键 切换 Tab
" 所有 TAB 标签页功能触发前导键位全部设定为 <Tab> 键
"------------------------------------------------------------------------------
noremap <silent><tab>1 1gt<cr>
noremap <silent><tab>2 2gt<cr>
noremap <silent><tab>3 3gt<cr>
noremap <silent><tab>4 4gt<cr>
noremap <silent><tab>5 5gt<cr>
noremap <silent><tab>6 6gt<cr>
noremap <silent><tab>7 7gt<cr>
noremap <silent><tab>8 8gt<cr>
noremap <silent><tab>9 9gt<cr>
noremap <silent><tab>0 10gt<cr>


"------------------------------------------------------------------------------
" TAB 标签页：创建，关闭，上一个，下一个，左移，右移
" 其实还可以用原生的 CTRL+PageUp, CTRL+PageDown 来切换标签
"------------------------------------------------------------------------------
noremap <silent><tab>n :tabnew<cr>
noremap <silent><tab>c :tabclose<cr>
if has('nvim')
	noremap <silent><tab><insert> :tabnew<cr>
	noremap <silent><tab><delete> :tabclose<cr>
endif

" 仅保留当前 TAB 标签页，关闭其他所有 TAB 标签页
noremap <silent><tab>o :tabonly<cr>

" 用 TAB 标签页显示所有缓冲区
noremap <silent><tab>s :tab sball<cr>

" 在当前路径下以新 TAB 标签页打开文件
noremap <tab>e :tabedit <c-r>=expand("%:p:h")<cr>/

" 所有 TAB 标签页循环谢欢
noremap <silent><tab>] :tabnext<cr>
noremap <silent><tab>[ :tabprevious<cr>

noremap <silent><s-tab> :tabprevious<cr>

" 左移 TAB 标签页
noremap <silent><tab><tab>[ :-tabmove<cr>
" 右移 TAB 标签页
noremap <silent><tab><tab>] :+tabmove<cr>

" 当前 TAB 标签页与上一个 TAB 标签页之间两者循环切换
augroup LastTab
	autocmd!
	if !exists('g:lasttab')
		let g:lasttab = tabpagenr()
	endif
	noremap <silent><tab><leader> :execute "tabn ".g:lasttab<cr>
	autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

" 左移 TAB 标签页
"function! Tab_MoveLeft()
"	let l:tabnr = tabpagenr() - 2
"	if l:tabnr >= 0
"		exec 'tabmove '.l:tabnr
"	endif
"endfunc
" 右移 TAB 标签页
"function! Tab_MoveRight()
"	let l:tabnr = tabpagenr() + 1
"	if l:tabnr <= tabpagenr('$')
"		exec 'tabmove '.l:tabnr
"	endif
"endfunc
"noremap <silent><tab><tab>[ :call Tab_MoveLeft()<cr>
"noremap <silent><tab><tab>] :call Tab_MoveRight()<cr>


"------------------------------------------------------------------------------
" 窗口切换：CTRL+hjkl
" 传统的分割窗口缓冲区移动光标键位
"------------------------------------------------------------------------------
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-,> <esc><c-w>p
vnoremap <c-h> <c-w>h
vnoremap <c-j> <c-w>j
vnoremap <c-k> <c-w>k
vnoremap <c-l> <c-w>l
vnoremap <c-,> <esc><c-w>p
inoremap <c-h> <esc><c-w>h
inoremap <c-j> <esc><c-w>j
inoremap <c-k> <esc><c-w>k
inoremap <c-l> <esc><c-w>l
inoremap <c-,> <esc><c-w>p

"------------------------------------------------------------------------------
" 窗口切换：<Tab>+上下左右
" 传统的分割窗口缓冲区移动光标键位
"------------------------------------------------------------------------------
" Tab+hjkl 窗口之间移动光标
noremap <tab>h <c-w>h
noremap <tab>j <c-w>j
noremap <tab>k <c-w>k
noremap <tab>l <c-w>l
noremap <tab>, <c-w>p

" Tab+上下左右 窗口之间移动光标
noremap <tab><left> <c-w>h
noremap <tab><down> <c-w>j
noremap <tab><up> <c-w>k
noremap <tab><right> <c-w>l
noremap <tab>, <c-w>p


"------------------------------------------------------------------------------
" Terminal 终端模式窗口切换
" iterm2 下 nvim 映射不出 ScrLk 键码 <F16>
" iterm2 下 vim 映射不出 Ctrl-` 键码, 且会将 <F16> 映射成 <S-F4>
"------------------------------------------------------------------------------
if has('nvim')
	noremap <f13> :split \| terminal<cr>
	noremap <c-`> :split \| terminal<cr>

	tnoremap <tab><left> <c-\><c-n><c-w>h
	tnoremap <tab><down> <c-\><c-n><c-w>j
	tnoremap <tab><up> <c-\><c-n><c-w>k
	tnoremap <tab><right> <c-\><c-n><c-w>l
	tnoremap <tab>, <c-\><c-n><c-w>p
	tnoremap <tab><esc> <c-\><c-n>
elseif v:version >= 800
	noremap <s-f1> :terminal<cr>

	set termwinkey=<c-w>
	tnoremap <tab><left> <c-w>h
	tnoremap <tab><down> <c-w>j
	tnoremap <tab><up> <c-w>k
	tnoremap <tab><right> <c-w>l
	tnoremap <tab>, <c-w>p
	tnoremap <tab><esc> <c-\><c-n>
endif


"------------------------------------------------------------------------------
" netrw 文件浏览器
" iterm2 下 nvim 映射不出 ScrLk 键码 <F16>
" iterm2 下 vim 映射不出 Ctrl-Esc 键码, 且会将 <F16> 映射成 <S-F4>
"------------------------------------------------------------------------------
if has('nvim')
	noremap <f16> :Lexplore<cr>
	noremap <c-esc> :Lexplore<cr>
else
	noremap <s-f4> :Lexplore<cr>
endif


"------------------------------------------------------------------------------
" 缓冲区分屏窗口的创建，删除，下一个，上一个，左移，右移
"------------------------------------------------------------------------------
" 查看缓冲区列表
noremap <silent><leader>ls :buffers<cr>
" 打开 buffer 缓冲区
noremap <leader><leader>b :buffers<cr>:buffer

" 横向等距分割当前窗口
noremap <silent><leader>sp :split<cr>:blast<cr>
" 纵向等距分割当前窗口
noremap <silent><leader>vs :vsplit<cr>:blast<cr>

" 跳转到下一个已被修改的 buffer 缓冲区
noremap <silent><leader>bm :bmodified<cr>

" 横向等距分割窗口显示所有缓冲区
noremap <silent><leader>ba :ball<cr>
" 纵向等距分割窗口显示所有缓冲区
noremap <silent><leader>bv :vertical ball<cr>

" 删除当前缓冲区
noremap <silent><leader>bd :bdelete<cr>


"------------------------------------------------------------------------------
" 缓存：插件 unimpaired 中定义了 [b, ]b 来切换缓存
"------------------------------------------------------------------------------
noremap <silent><leader>b] :bnext<cr>
noremap <silent><leader>b[ :bprevious<cr>

" 在当前缓冲区与上一个缓冲区之间循环切换
augroup LastBuf
	autocmd!
	if !exists('g:lastbuf')
		let g:lastbuf = bufnr('$')
	endif
	noremap <leader>b<leader> :execute 'buffer '.g:lastbuf<cr>
	autocmd BufLeave * let g:lastbuf = bufnr('$')
augroup END


"------------------------------------------------------------------------------
" 文件对比 Diff
"------------------------------------------------------------------------------
noremap <leader>do :DiffOrig<cr>
noremap <leader>dq :diffoff!<cr>
noremap <leader>dt :diffthis<cr>
noremap <leader>du :diffupdate<cr>
noremap <leader>ds :vertical diffsplit <c-r>=expand("%:p:h")<cr>/
noremap <leader>dp :vertical diffpatch <c-r>=expand("%:p:h")<cr>/


"------------------------------------------------------------------------------
" 拼写检查
"------------------------------------------------------------------------------
"nnoremap <leader>sc :setlocal spell!<cr>
"nnoremap <leader>s] ]s
"nnoremap <leader>s[ [s
"nnoremap <leader>sa zg
"nnoremap <leader>s? z=


