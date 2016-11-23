"syntax on
execute pathogen#infect()
syntax enable
set nocompatible
set autoindent
" Mouse Mode
set ttymouse=xterm2
set mouse=a

" makes screen redrawing/movement  faster
set lazyredraw
set ttyfast

" Use 256 colours
" probably unecessary if we have set things up right elsewhere
set t_Co=256

" Show trailing whitespace and spaces before a tab:
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=66 guibg=#afd787
:highlight ExtraWhitespace ctermbg=66 guibg=#afd787
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/

set background=light   " default
colors peaksea
hi Normal ctermbg=None
"colorscheme solarized
"for transparent background
"let g:zenburn_transparent = 1
"colorscheme zenburn
"set background=dark
" hi SpellBad ctermbg=darkblue " if using light colors on dark background

" Set cursorline here to override values in colors theme
set cursorline
"set spell bad to bold so we can see it on the current line
hi Spellbad cterm=undercurl,bold
" turn cursor line on/off when entering insert mode
" doesn't toggle so we can still use f7 and not confuse ourselves
au InsertEnter * set nocursorline
au InsertLeave * set cursorline

" for python
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
filetype indent plugin on
filetype plugin on
filetype indent on
" set omnifunc=syntaxcomplete#Complete

"set cwd/pwd to directory of file being edited, not directory vim started in
"enables .pylintrc in file dir to be used automatically
"may break some plugins, but doesn't appear to.
set autochdir

" turn off docstring pop up in jedi-vim
autocmd FileType python setlocal completeopt-=preview
" Jump to the last position when reopening a file
 if has("autocmd")
   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" remove trailing whitespace on save in selected filetypes
autocmd FileType py,css,scss,js,html autocmd BufWritePre <buffer> :%s/\s\+$//e
" end auto arguments


let g:jedi#show_call_signatures=0
"set underscore as word boundary
set iskeyword-=_
" so we can see the leader key.
set showcmd

"Syntastic checkers
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylint_args = "--disable=F0401 --generated-members=objects"
" let g:syntastic_python_pylint_args = "--load-plugins pylint_django"
let g:syntastic_python_checkers = ['flake8', 'pylint']
" frosted is prefereable but flake8 has pyflakes and pep8
" 'frosted', 'pep8',  prospector ,  'python', 'pylama']
let g:syntastic_aggregate_errors = 1

" for vim-airline
let g:airline_powerline_fonts=1
set laststatus=2
"let g:airline_theme='jellybean'
let g:airline_theme='understated'
"let g:airline_theme='murmur'
"let g:airline_theme='raven'
"let g:airline_theme='silver'
"let g:airline_theme='zenburn'
" set cursor shape
" N.B. Terminator at least overides this, gnome terminal doesn't
" let you sent (no) blink
"" use bli
""if &term =~ '^xterm'
""if &term =~ '^gnome-256color'
"    " insert mode solid underscore
""    let &t_SI .= "\<Esc>[4 q"
"    " other wise solid block
""    let &t_EI .= "\<Esc>[2 q"
"    " 1 or 0 -> blinking block
"    " 2 -> solid block
"    " 3 -> blinking underscore
"    " 4 -> solid underscore
"    " Recent versions of xterm (256 or above) also support
"    " 5 -> blinking vertical bar
"    " 6 -> solid vertical bar
""endif

" Rainbow Parens
let g:bold_parentheses = 0  "off
let g:rbpt_colorpairs = [
    \ ['136',       'RoyalBlue3'],
    \ ['036',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['124',   'firebrick3'],
    \ ['068',    'RoyalBlue3'],
    \ ['202',     'SeaGreen3'],
    \ ['248', 'DarkOrchid3'],
    \ ['052',       'firebrick3'],
    \ ['132',        'RoyalBlue3'],
    \ ['136',       'SeaGreen3'],
    \ ['067', 'DarkOrchid3'],
    \ ['087',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['lightgrey',         'firebrick3'],
    \ ]

" set html to jinja since the latter also does the former
"au BufWinEnter,BufRead,BufNewFile *.html set filetype=jinja

" Switch to dark background
function! SwitchBackground()
    if &background=='dark'
        set background=light
        hi Normal  ctermfg=Black ctermbg=None
        hi NonText ctermbg=None
        hi MatchParen ctermbg=150

    elseif &background=='light'
        set background=dark
        hi Normal ctermbg=Black
        hi NonText ctermfg=White ctermbg=Black
    endif
endfunction

" Quote a word consisting of letters from iskeyword.
nnoremap <silent> qw :call Quote('"')<CR>
nnoremap <silent> qs :call Quote("'")<CR>
nnoremap <silent> wq :call UnQuote()<CR>
function! Quote(quote)
  set iskeyword+=_
  normal mz
  exe 's/\(\k*\%#\k*\)/' . a:quote . '\1' . a:quote . '/'
  normal `zl
  set iskeyword-=_
endfunction

function! UnQuote()
  set iskeyword+=_
  normal mz
  exe 's/["' . "'" . ']\(\k*\%#\k*\)[' . "'" . '"]/\1/'
  normal `z
  set iskeyword-=_
endfunction

function! RBParens()
    RainbowParenthesesToggle
    RainbowParenthesesLoadSquare
    RainbowParenthesesLoadBraces
endfunction


" type table,,, to get <table></table> etc automatically close a tag
imap ,,, <esc>bdwa<<esc>pa><cr></<esc>pa><esc>kA
map <F2>:call SwitchBackground()<CR>
map <F3> <ESC>:set invnumber<CR>
map <F4> <ESC>:set spell!<CR>
map <F5> <ESC>:filetype detect<CR>
map <F6> <ESC>:set paste!<CR>
map <F7> <ESC>:set cursorline!<CR>
" <F8> for .vimrc-local
" Press F9 to toggle highlighting on/off, and show current value.
:noremap <F9> :set hlsearch! hlsearch?<CR>

" Press F10 to close location list
":noremap <F10> :lcl<CR>

" Press F10 to close location list and clear syntastic markers
:noremap <F10> :SyntasticReset<CR>

" Press Ctrl+F12 to toggle rainbow params
set <F12>=[24;5~
:noremap <F12> <ESC>:call RBParens()<CR>

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" CamelCase Movement

" Use one of the following to define the camel characters.
" Stop on capital letters.
let g:camelchar = "A-Z"
" Also stop on numbers.
let g:camelchar = "A-Z0-9"
" Include '.' for class member, ',' for separator, ';' end-statement,
" and <[< bracket starts and "'` quotes.
let g:camelchar = "A-Z0-9.,;:{([`'\""
nnoremap <silent><C-Left> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><C-Right> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><C-Left> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><C-Right> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
vnoremap <silent><C-Left> :<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>v`>o
vnoremap <silent><C-Right> <Esc>`>:<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>v`<o


" Add support for markdown files in tagbar.
let g:tagbar_type_mkd = {
    \ 'ctagstype': 'mkd',
    \ 'ctagsbin' : '/home/paul/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
" disable folding in markdown
let g:vim_markdown_folding_disabled=1

"better git commits
autocmd Filetype gitcommit setlocal spell textwidth=72

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" add a space to comments
let g:NERDSpaceDelims = 1

" triple quote balance auto-insertion
au FileType python let b:delimitMate_nesting_quotes = ['"']


" fix for incorrect highlighting casued by long doc strings
" check from start of file to determine syntax highlighting
autocmd BufEnter * :syntax sync fromstart
" alternatively set minimum no of lines backwards to check
" replace with next line if thing get to slow, count = no of lines to check
" let c_minlines=200
set tags=~/.mytags
if filereadable(glob("~/.vimrc-local"))
    source ~/.vimrc-local
endif
