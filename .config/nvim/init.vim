" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'unblevable/quick-scope'
Plug 'dominikduda/vim_current_word'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'psliwka/vim-smoothie'
call plug#end()

set termguicolors

let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

augroup qs_colors
    autocmd!
    autocmd vimenter * colorscheme gruvbox
    autocmd vimenter * AirlineRefresh
    autocmd vimenter,ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd vimenter,ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    autocmd vimenter,ColorScheme * highlight MemberVariable guifg=#6b877c
    autocmd vimenter,ColorScheme * highlight LocalVariable guifg=#97bfaf
augroup END

set hidden
set background=dark
set mouse=a
set clipboard=unnamedplus
set relativenumber
set scrolloff=3
set wildmode=list:longest,full

set tabstop=4
set shiftwidth=4
set expandtab
" Disable the current word plugin by default
let g:vim_current_word#enabled = 0

autocmd FileType c,cpp,java setlocal commentstring=//\ %s

let mapleader = " "
tnoremap <Esc> <C-\><C-n>

" Add a new line by normal mode enter
nnoremap <CR> m`O<Esc>``
" And delete by backspace
nnoremap <BS> _dd

" Lets save by ctrl-s
nnoremap <C-s> :w<CR>
vnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

let g:surround_no_mappings = 1
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap cS <Plug>CSurround
nmap s  <Plug>Ysurround
nmap S  <Plug>YSurround
nmap ss <Plug>Yssurround
nmap Ss <Plug>YSsurround
nmap SS <Plug>YSsurround
xmap s  <Plug>VSurround
xmap gs <Plug>VgSurround

" ctrl-j ctr-k mappings
" Use ctrl-j and ctrl-k for navigating search results
let g:is#do_default_mappings = 0
cnoremap <C-j> <C-g>
cnoremap <C-k> <C-t>
" and to navigate pum in insert mode
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Scrolling in visual and normal mode
nnoremap <C-j> 10<C-e>
vnoremap <C-j> 10<C-e>
nnoremap <C-k> 10<C-y>
vnoremap <C-k> 10<C-y>

let g:navigation_mode = ''

function Navigate_j()
    if  g:navigation_mode ==# 'scroll'
        execute "normal \<C-d>"
    elseif g:navigation_mode ==# 'outline'
        execute "normal! :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})\<cr>zz"
    elseif g:navigation_mode ==# 'find'
        execute "normal! nzz"
    elseif g:navigation_mode ==# 'method'
        execute "normal! ]mzz"
    elseif g:navigation_mode ==# 'paragraph'
        execute "normal! }zz"
    elseif g:navigation_mode ==# 'list'
        execute "normal! :CocNext\<cr>zz"
    elseif g:navigation_mode ==# 'quickfix'
        execute "normal! :cnext\<cr>zz"
    elseif g:navigation_mode ==# 'location'
        execute "normal! :lnext\<cr>zz"
    else
        execute "normal! j" 
    endif
endfunction

function Navigate_k()
    if  g:navigation_mode ==# 'scroll'
        execute "normal \<C-u>"
    elseif g:navigation_mode ==# 'outline'
        execute "normal! :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})\<cr>zz"
    elseif g:navigation_mode ==# 'find'
        execute "normal! Nzz"
    elseif g:navigation_mode ==# 'method'
        execute "normal! [mzz"
    elseif g:navigation_mode ==# 'paragraph'
        execute "normal! {zz"
    elseif g:navigation_mode ==# 'list'
        execute "normal! :CocPrev\<cr>"
    elseif g:navigation_mode ==# 'quickfix'
        execute "normal! :cprev\<cr>zz"
    elseif g:navigation_mode ==# 'location'
        execute "normal! :lprev\<cr>zz"
    else
        execute "normal! k"
    endif
endfunction

function Navigate_h()
    if  g:navigation_mode ==# 'scroll'
        execute "normal \<C-b>"
    elseif g:navigation_mode ==# 'outline'
        execute "normal! :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})\<cr>zz"
    else
        execute "normal! h" 
    endif
endfunction

function Navigate_l()
    if  g:navigation_mode ==# 'scroll'
        execute "normal \<C-f>"
    elseif g:navigation_mode ==# 'outline'
        execute "normal! :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})\<cr>zz"
    else
        execute "normal! l" 
    endif
endfunction

nnoremap <silent>j :call Navigate_j()<cr>
nnoremap <silent>k :call Navigate_k()<cr>
nnoremap <silent>h :call Navigate_h()<cr>
nnoremap <silent>l :call Navigate_l()<cr>
nnoremap <silent>nf :let g:navigation_mode='find'<cr>
nnoremap <silent>nli :let g:navigation_mode='list'<cr>
nnoremap <silent>nlo :let g:navigation_mode='location'<cr>
nnoremap <silent>nm :let g:navigation_mode='method'<cr>
nnoremap <silent>no :let g:navigation_mode='outline'<cr>
nnoremap <silent>np :let g:navigation_mode='paragraph'<cr>
nnoremap <silent>nq :let g:navigation_mode='quickfix'<cr>
nnoremap <silent>ns :let g:navigation_mode='scroll'<cr>
nnoremap <silent><esc> :let g:navigation_mode=''<cr>
"
" The below stuff is taken from the coc.nvim documentation
" Some servers have issues with backup files, see coc.nvim #649.

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ g:coc_enabled ? (
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
    \ ) : "\<TAB>"
        
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup cocsettings
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

nmap <leader>b :CocList buffers<cr>
nmap <leader>c <C-w>c
nmap <leader>e :CocCommand explorer<cr>
nmap <leader>f :CocList<cr>
nmap <leader>fb :CocList buffers<cr>
nmap <leader>fd :CocList diagnostics<cr>
nmap <leader>ff :CocList files<cr>
nmap <leader>fF :CocList files<space>
nmap <leader>fg :CocList grep<cr>
nmap <leader>fG :CocList grep<space>
nmap <leader>fh :CocList helptags<cr>
nmap <leader>fl :CocList lines<cr>
nmap <leader>fm :CocList mru<cr>
nmap <leader>fo :CocList outline<cr>
nmap <leader>fr :CocListResume<cr>
nmap <leader>fs :CocList --interactive --no-sort symbols<cr>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>K :split<cr>
nmap <leader>l <C-w>l
nmap <leader>L :vsplit<cr>
nmap <leader>n :CocNext<cr>
nmap <leader>N :CocPrev<cr>
nmap <leader>ov :edit $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>

nmap m <Plug>(easymotion-s)


"***** Syntax highlighting for ccls ***** 

" Preprocessor Skipped Regions:
"
" This is used for false branches of #if or other preprocessor conditions
hi link LspCxxHlSkippedRegion Comment

" This is the first and last line of the preprocessor regions
" in most cases this contains the #if/#else/#endif statements
" so it is better to let syntax do the highlighting.
hi link LspCxxHlSkippedRegionBeginEnd Normal

" Syntax Highlighting:
"
" Custom Highlight Groups
hi link LspCxxHlGroupEnumConstant Constant
hi link LspCxxHlGroupNamespace Type

hi link LspCxxHlSymUnknown Normal

" Type
hi link LspCxxHlSymClass Structure
hi link LspCxxHlSymStruct Structure
hi link LspCxxHlSymEnum Structure
hi link LspCxxHlSymTypeAlias Type
hi link LspCxxHlSymTypeParameter Type

" Function
hi link LspCxxHlSymFunction Function
hi link LspCxxHlSymMethod Function
hi link LspCxxHlSymStaticMethod Function
hi link LspCxxHlSymConstructor Function

" EnumConstant
hi link LspCxxHlSymEnumMember LspCxxHlGroupEnumConstant

" Preprocessor
hi link LspCxxHlSymMacro Macro

" Namespace
hi link LspCxxHlSymNamespace LspCxxHlGroupNamespace

" Variables
hi link LspCxxHlSymVariable LocalVariable
hi link LspCxxHlSymParameter Identifier
hi link LspCxxHlSymField MemberVariable
