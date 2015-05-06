"----------------------------------------
" Execute pathogen plugin at vim startup
"----------------------------------------
execute pathogen#infect()
filetype plugin indent on

"---------------------
" Basic text editings
"---------------------
set nocompatible " disables the compatible mode. Runs the vim in enhanced mode.
syntax on " enables syntax hilighting for programming languages
set number " enables line numbering
set mouse=a " allows you to click around the text editor with your mouse to move the cursor
set showmatch " hlights the matching brackets in programming languages
set autoindent " enables auto indent when a new line is inserted
set smartindent " automatically indents lines after opening a bracket in a programming language
set tabstop=4 " how much Vim gives to a tab
set shiftwidth=4 " assists code formatting
set expandtab " replace tab with spaces
set smarttab " improves tabbing
set backspace=2 " this makes backspace functions like it does in other programs
set smartcase " ignores case on search unless specified
set foldmethod=manual " lets you hide sections of code
set ignorecase " do case-insensitive search
set colorcolumn=80 " colorize the 80th column 

"------------------------
" Comment blocks of code
"------------------------
autocmd FileType c,cpp,java,scala,javascript let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,c :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,u :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

"--------------------------------------------------
" Disable folding for Markdown syntax highlighting
"--------------------------------------------------
let g:vim_markdown_folding_disabled=1 

"---------------------
" Use solarized theme
"---------------------
let g:solarized_termcolors=256
let g:solarized_termtrans=1
syntax enable
set background=dark
colorscheme solarized
set guifont=Monaco:h11:cANSI " set fonts for gui vim
set guioptions=egmrt " hide the gui menubar

"-------------------
" NERDTree settings
"-------------------
" autocmd vimenter * NERDTree " open NERDTree automatically when vim starts up
autocmd vimenter * if !argc() | NERDTree | endif " open NERDTree automatically when vim starts up if no files were specified
map <C-n> :NERDTreeToggle<CR> " press ctrl+n to open NERDTree manually 
set autochdir " change to the current work directory automatically
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " close vm if the only window left open is a NERDTree

"------------------------------------------
" JavaScript libraries syntax highlighting
"------------------------------------------
" autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
" autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
" autocmd BufReadPre *.js let b:javascript_lib_use_lo-dash = 1
