""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Joney Lai <joney.lai@gmail.com>
"
" License:
"       GPLv3.0
"
" Sections:
"    -> Git config/commit
"    -> C/C++
"    -> Python
"    -> HTML/CS/Javascript common
"    -> Javascript
"    -> Vue.js
"    -> CoffeeScript
"    -> Twig
"    -> Shell: tmux nvim colors
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git config/commit
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType gitcommit setl textwidth=72
au FileType gitcommit call setpos('.', [0, 1, 1, 0])


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => C/C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.c,*.h setl filetype=c
au BufNewFile,BufRead *.cpp setl filetype=cpp

au FileType c,cpp setl foldenable
au FileType c,cpp setl foldmethod=indent
au FileType c,cpp setl cindent

" HACK: vim-polyglot/syntax/c.vim highlight Todo keyword
au FileType c,cpp syn keyword cTodo TODO FIXME XXX BUG HACK NOTE WARNING contained
au FileType c,cpp let b:AutoPairs = {
\   '(':')', '[':']', '{':'}',
\   "'":"'", '"':'"', '`':'`',
\}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.jinja setl syntax=jinja2
au BufNewFile,BufRead *.mako setl filetype=mako
au BufNewFile,BufRead *.jinja,*.mako :ColorHighlight!

au FileType python setl foldenable
au FileType python setl foldmethod=indent
au FileType python setl cindent
au FileType python setl cinkeys-=0#
au FileType python setl indentkeys-=0#

" HACK: vim-polyglot/syntax/python.vim highlight Todo keyword
au FileType python syn keyword pythonTodo TODO FIXME XXX BUG HACK NOTE WARNING contained
" NOTE: python triple double-quotation-markers keyword
au FileType python let b:AutoPairs = {
\   '(':')', '[':']', '{':'}',
\   "'":"'", '`':'`', 
\   '"""':'"""',
\}

"au FileType python inoremap <buffer> $r return<space>
"au FileType python inoremap <buffer> $i import<space>
"au FileType python inoremap <buffer> $c class<space>
"au FileType python inoremap <buffer> $d def<space>
"au FileType python map <buffer> <leader>1 /class<space>
"au FileType python map <buffer> <leader>2 /def<space>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ShortTabStop()
    setl tabstop=2
    setl softtabstop=2
    setl shiftwidth=2
    setl expandtab
    :ColorHighlight!
endfunction
au FileType javascript,html,xml,yaml,vue call ShortTabStop()
au FileType vue,xml,html let b:AutoPairs = {
\   '(':')', '[':']', '{':'}', '<':'>',
\   "'":"'", '"':'"', '`':'`',
\}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => JavaScript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
au FileType javascript call JavaScriptFold()
au FileType javascript setl nofoldenable
au FileType javascript setl nocindent

au FileType javascript let g:syntastic_javascript_checkers=['eslint']

" HACK: vim-polyglot/syntax/javascript.vim highlight Todo keyword
au FileType javascript syn keyword jsCommentTodo TODO FIXME XXX BUG HACK NOTE WARNING contained

"au FileType javascript inoremap <buffer> $r return<space>
"au FileType javascript inoremap <buffer> $a alert();<esc>hi
"au FileType javascript inoremap <buffer> $l $log();<esc>hi


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vue.js
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable vim-vue syntax
au FileType vue syntax sync fromstart

" Fix vim slow down when using this plugin.
au FileType vue let g:vue_disable_pre_processors = 1

" HACK: vim-polyglot/syntax/javascript.vim highlight Todo keyword
au FileType vue syn keyword jsCommentTodo TODO FIXME XXX BUG HACK NOTE WARNING contained

" NERDCommenter work with vim-vue, see help for more details.
let g:ft = ''
function! NERDCommenter_before()
    if &ft == 'vue'
        let g:ft = 'vue'
        let stack = synstack(line('.'), col('.'))
        if len(stack) > 0
            let syn = synIDattr((stack)[0], 'name')
            if len(syn) > 0
                exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
            endif
        endif
    endif
endfunction
function! NERDCommenter_after()
    if g:ft == 'vue'
        setf vue
        let g:ft = ''
    endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SCSS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SCSSFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType scss call SCSSFold()

" HACK: vim-polyglot/syntax/scss.vim highlight Todo keyword
au FileType scss syn keyword scssTodo TODO FIXME XXX BUG HACK NOTE WARNING contained


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Twig
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead *.twig set syntax=html filetype=html


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shell
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$TMUX') 
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color 
    endif
endif

