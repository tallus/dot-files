"syntax on
execute pathogen#infect()
syntax enable
set nocompatible
set autoindent

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
" turn off docstring pop up in jedi-vim
autocmd FileType python setlocal completeopt-=preview
" Jump to the last position when reopening a file
 if has("autocmd")
   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" and auto arguments
let g:jedi#show_call_signatures=0
"set underscore as word boundary
set iskeyword-=_
" so we can see the leader key.
set showcmd
"Syntastic checkers
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8', 'pylint', 'pep8', 'frosted']
"prospector ,  'python', 'pylama']
let g:syntastic_python_pylint_args = "--disable=F0401 --generated-members=objects"


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

" for gnome-terminal
au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape underline"
au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
au VimEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"

" set html to jinja since the latter also does the former
au BufWinEnter,BufRead,BufNewFile *.html set filetype=jinja

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

" type table,,, to get <table></table> etc automatically close a tag
imap ,,, <esc>bdwa<<esc>pa><cr></<esc>pa><esc>kA
map <F2>:call SwitchBackground()<CR>
map <F3> <ESC>:set invnumber<CR>
map <F4> <ESC>:set spell!<CR>
map <F5> <ESC>:filetype detect<CR>
map <F6> <ESC>:set paste!<CR>
map <F7> <ESC>:set cursorline!<CR>
"for tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autoclose=1
" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F9> :set hlsearch! hlsearch?<CR>

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


set tags=~/.mytags
