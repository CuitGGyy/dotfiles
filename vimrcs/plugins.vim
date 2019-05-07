"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Joney Lai <joney.lai@gmail.com>
"
" License:
"       GPLv3.0
"
" Sections:
"    -> BufExplorer
"    -> MRU Files
"    -> Ctrl-P
"    -> NERDTree
"    -> Airline
"    -> Vim Grep
"    -> Ack
"    -> TagBar
"    -> indentLine
"    -> NERDCommenter
"    -> Autopairs
"    -> ALE (Asynchronous Lint Engine)
"    -> colorizer
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CTRL-P
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_match_window = 'max:15'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_by_filename = 1

let g:ctrlp_custom_ignore = {
\   'dir':    '\v[\/](node_modules)|(\.(git|hg|svn|bzr)$)',
\   'file':   '\v\.(exe|dll|so|DS_Store)$',
\   'link':   'SOME_BAD_SYMBOLIC_LINKS',
\}

let g:ctrlp_lazy_update = 1
let g:ctrlp_default_input = 0

let g:ctrlp_mruf_max = 500
let g:ctrlp_mruf_exclude = '/tmp/.*\|/var/tmp/.*'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_mruf_default_order = 1

let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlPLastMode --dir'
map <leader>p :CtrlP<cr>
map <leader>o :CtrlPBuffer<cr>
map <leader>r :CtrlPMRU<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize = 35

let NERDTreeIgnore = ['\~$', '\.pyc$', '__pycache__']
"let NERDTreeMinimalUI = 1
"let NERDTreeChDirMode = 1
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1
let NERDTreeShowAutoCenter = 1
let NERDTreeShowLineNumbers = 1

map <leader>[ :NERDTreeToggle<cr>

"map <leader>nn :NERDTreeToggle<cr>
"map <leader>nb :NERDTreeFromBookmark<space>
"map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable tabline
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" 'default'|'jsformatter'|'unique_tail'|'unique_tail_improved'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Enable airline support ALE
let g:airline#extensions#ale#enabled = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .git .hg .svn .bzr generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires silver-searcher - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case --nocolor --column --nogroup'
endif

" Open Ack and put the cursor in the right position
"nnoremap <leader>g :Ack!<space>
map <leader>g :Ack!<space>

" Do :help cope if you are unsure what cope is. It's super useful!
" When you search with Ack, display your results in cope by doing:
"   <leader>g
" To go to the next search result do:
"   ]g
" To go to the previous search results do:
"   [g
"
nmap <silent> ]g :cn<cr>
nmap <silent> [g :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("mac") || has("macunix")
    let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
elseif has("linux") || has("unix")
    let g:tagbar_ctags_bin = '/usr/bin/ctags'
elseif has("win16") || has("win32")
    let g:tagbar_ctags_bin = 'C:\Vim\ctags.exe'
endif
"let g:tagbar_autopreview = 1
let g:tagbar_width = 35
let g:tagbar_right = 1
let g:tagbar_sort = 0

map <leader>] :TagbarToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => indentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentLine will overwrite 'conceal' color with grey by default. 
" If you want to highlight conceal color with your colorscheme, 
" disable by:
"let g:indentLine_setColors = 0

" Vim
"let g:indentLine_color_term = 239
" GVim
"let g:indentLine_color_gui = '#A4E57E'
" none X terminal
"let g:indentLine_color_tty_light = 7  " (default: 4)
"let g:indentLine_color_dark = 1  " (default: 2)
" Background (Vim, GVim)
"let g:indentLine_bgcolor_term = 202
"let g:indentLine_bgcolor_gui = '#FF5F00'

" customize indent line character
"let g:indentLine_char = '|'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" customize leading space character
"let g:indentLine_leadingSpaceChar = '·'
"let g:indentLine_leadingSpaceEnabled = 1

" If you want to keep your conceal setting,
" uncomment statement below
"let g:indentLine_setConceal = 0

" set 1 to performance better
let g:indentLine_faster = 1

" Enable indentLine at vim start, disable by default.
"let g:indentLine_enabled = 0

map <leader><tab> :IndentLinesToggle<cr>
map <leader><leader><tab> :LeadingSpaceToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERD Commenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0

" Tells the script to always remove the extra spaces when uncommenting
" (regardless of whether NERDSpaceDelims is set)
let g:NERDRemoveExtraSpaces = 0

" Use compact syntax for prettified multi-line comments
"let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
" one of 'none', 'left', 'start', or 'both'.
let g:NERDDefaultAlign = 'left'

" Tells the script whether to remove alternative comment delimiters when uncommenting
let g:NERDRemoveAltComs = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {
\   'python': { 'left': '#', },
\   'vue': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/', }
\}

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_python = 0
let g:NERDAltDelims_vue = 0

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
" When this option is set to 1, NERDCommenterToggle will check all selected line,
" if there have oneline not be commented, then comment all lines.
"let g:NERDToggleCheckAllLines = 1

" Shortcut <leader>c<space> <plug>NERDCommenterToggle works uncomfortably.
map <leader>c<leader> <plug>NERDCommenterInvert
 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autopairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:AutoPairsMapBS = 0
let g:AutoPairsMapCh = 1
"let g:AutoPairsMapCR = 1
let g:AutoPairsMapCenterLine = 0
"let g:AutoPairsMapSpace = 1
"let g:AutoPairsMapMultilineClose = 1

" System Shortcuts
let g:AutoPairsShortcutToggle = ''
"let g:AutoPairsShortcutToggle = '<M-p>'
"let g:AutoPairsShortcutFastWrap = '<M-e>'
"let g:AutoPairsShortcutJump = '<M-n>'

" Fly Mode
"let g:AutoPairsFlyMode = 0
"let g:AutoPairsShortcutBackInsert = '<M-b>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns string if ale has errors or warnings
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    "return l:counts.total == 0 ? 'OK' : printf(
    return l:counts.total == 0 ? '' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
" If no vim-airline, statusline format below with  ALE linter status can use instead.
"set statusline=\ [%{mode()}%H%M%R%W%{Paste()}]\ %<%F%=[%{&ff}]\ %p%%,\ %l/%L\ :\ %c\ %y\ %(%{LinterStatus()}\ %)

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" Declare linter support dictionary for languages
let g:ale_linters = {
\   'c': ['clang'],
\   'c++': ['clang'],
\   'python': ['flake8'],
\   'reStructuredText': ['rstcheck'],
\   'javascript': ['eslint'],
\   'css': ['stylelint'],
\}

"let g:ale_fixers = {
"\   'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8', ],
"\}

" Declare java compiler options
"let g:ale_java_javac_options = '-encoding UTF-8 -J-Duser.language=en'

" Disabling highlighting
"let g:ale_set_highlights = 0
"highlight ALEError ctermbg=DarkRed
"highlight ALEWarning ctermbg=DarkMagenta

"let g:ale_sign_column_always = 1
"let g:ale_sign_error = '>>'
"let g:ale_sign_warning = '--'

" g:ale_echo_msg_format where:
"   %s is the error message itself
"   %...code...% is an optional erro code, and most characters can be written between the % characters.
"   %linter% is the linter name
"   %serverity% is the serverity type
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %s [%serverity%]'

" Use the quickfix list instead of the loclist
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1

" Show vim windows for the loclist or quickfix items when a file
" contains warnings or errors.
"let g:ale_open_list = 1
" Combining ALE with other plugin which sets quickfix errors, etc.
"let g:ale_keep_list_window_open = 1

map <leader>aa :ALEToggle<cr>
map <leader>ad :ALEDetail<cr>

nmap <silent> ]a <plug>(ale_next_wrap)
nmap <silent> [a <plug>(ale_previous_wrap)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorizer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If you don't want to enable colorizer at startup, set the following:
let g:colorizer_startup = 0

" If you want completely not to map any key, set the following:
let g:colorizer_nomap = 1

" By default, <leader>tc is mapped to ColorToggle. If you want to use another
" key map, do like this:
"nmap ,tc <plug>Colorizer
" but default shortcut don't work fine, so map colorizer toggle fellow:
nmap <leader><leader>c <plug>Colorizer

" To use solid color highlight, set this in your vimrc (later change won't
" probably take effect unless you use ':ColorHighlight!' to force update).
" set it to 0 or 1 to use a softened foregroud color.
"let g:colorizer_fgcontrast = -1

" There are color strings in the format #RRGGBBAA and #AARRGGBB. The former is
" more common so it's the default. If you want the latter, set the following:
"let g:colorizer_hex_alpha_first = 1
" You can toggle the recognized alpha position by
"call colorizer#AlphaPositionToggle()

