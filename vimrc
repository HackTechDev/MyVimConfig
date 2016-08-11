set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
set noswapfile

execute pathogen#infect()
syntax on
filetype plugin indent on

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo
nnoremap <F3> :MundoToggle<CR>
let g:mundo_width = 40
let g:mundo_preview_height = 15
let g:mundo_right = 1


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Empêcher la retro-compatibilité avec Vim l'ancètre
set nocompatible
" Affichage des numéros de lignes
set number 
" Afficher une barre de statut (va avec Lightline)
set laststatus=2 
" Surligner la ligne courante 
set cursorline 
" Menu pour la complétion 
set wildmenu 
" Afficher le titre du fichier dans le terminal 
set title 


" Recherche

" Commencer à chercher dès qu'on tape un texte de recherche
set incsearch 
" Surligner les résultats d'une recherche
set hlsearch 
" Ne pas tenir compte de la casse ...
set ignorecase 
" ... sauf si on tape des majuscules
set smartcase 
 


" Indentation
" 1 tabulation = 4 espaces
set tabstop=4
" Une indentation = 4 espaces
set shiftwidth=4


" Raccourcis clavier
" Ctrl+N lance NerdTree
map <C-n> :NERDTreeTabsToggle<CR>
" Ctrl+U lance Mundo
map <C-u> :MundoToggle<CR>
" Ctrl+A ou Z (dés)active les numéros de lignes
map <C-a> :set nonumber<CR>
map <C-z> :set number<CR>
" Ctrl+F lance une recherche
map <C-f> /
map <F2> :NERDTreeTabsToggle<CR>


" Onglet/tab
set showtabline=2
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
nnoremap <C-n> :tabe<CR>


" Folder

set foldmethod=manual
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Split


" Inverser j et k en mode normal
nnoremap j k
nnoremap k j

" Inverse j and k keys in visual mode
xnoremap j k
xnoremap k j


" 
set paste

" No comment when enter
set formatoptions-=cro


" Session
au VimLeave * call VimLeave()
au VimEnter * call VimEnter()
let g:PathToSessions = $HOME . "/.vim/sessions"

function! VimEnter()
  if argc() == 0
    " gvim started with no files
    if has("browse") == 1
      let g:SessionFileName = browse(0, "Select Session", g:PathToSessions, "/LastSession.vim")
      if g:SessionFileName != ""
        exe "source " . g:SessionFileName
      endif
    else
      " For non-gui vim
      let LoadLastSession = confirm("Restore last session?", "&Yes\n&No")
      if LoadLastSession == 1
        exe "source " . g:PathToSessions . "/LastSession.vim"
      endif
    endif
  endif
endfunction

function! VimLeave()
  exe "mksession! " . g:PathToSessions . "/LastSession.vim"
  if exists("g:SessionFileName") == 1
    if g:SessionFileName != ""
      exe "mksession! " . g:SessionFileName
    endif
  endif
endfunction

" A command for setting the session name
com! -nargs=1 SetSession :let g:SessionFileName = g:PathToSessions . "/" . <args> . ".vim"
" .. and a command to unset it
com! -nargs=0 UnsetSession :let g:SessionFileName = ""
