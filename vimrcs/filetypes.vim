""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Jonet Lai <joney.lai@gmail.com>
"
" Sections:
"    -> Git commit
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
" => Git commit
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType gitcommit setl textwidth=72
au FileType gitcommit call setpos('.', [0, 1, 1, 0])


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.jinja setl syntax=jinja2
au BufNewFile,BufRead *.mako setl ft=mako
au BufNewFile,BufRead *.jinja,*.mako :ColorHighlight!

au FileType python setl foldmethod=indent
au FileType python setl cindent
au FileType python setl cinkeys-=0#
au FileType python setl indentkeys-=0#

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
au FileType xml,html let b:AutoPairs['<']='>'


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
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript let g:syntastic_javascript_checkers=['eslint']

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

" Use existing configuration/plugins, but maybe cause problem.
"au BufRead,BufNewFile *.vue setlocal filetype=vue.javascript.css.html

" NERDCommenter work with vim-vue, see help for more details.
let g:ft = ''
function! NERDCommenter_before()
    if &ft == 'vue'
        let g:ft = 'vue'
        let stack = synstack(line('.'), col('.'))
        if len(stack) > 0
            let syn = synIDattr((stack)[0], 'name')
            if len(syn) > 0
                " NERDCommenter help recommend fellow:
                "let syn = tolower(syn)
                "exe 'setf '.syn
                " vim-vue recommend fellow:
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
" => CoffeeScript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()


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

