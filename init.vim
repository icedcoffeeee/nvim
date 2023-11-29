set nocompatible

" PLUGINS ----------------------------------------------------------{{{
call plug#begin('~/vimfiles/plugged')

Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'olivercederborg/poimandres.nvim'
Plug 'navarasu/onedark.nvim'

Plug 'preservim/nerdtree'
Plug 'terrortylor/nvim-comment'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mg979/vim-visual-multi'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'nvim-lualine/lualine.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex'
Plug 'Konfekt/FastFold'
Plug 'tikhomirov/vim-glsl'
Plug 'preservim/vim-markdown'

call plug#end()

" }}}

" THEMING ----------------------------------------------------------{{{
set t_Co=256

lua << EOF
    require'nvim_comment'.setup {}
    require'onedark'.setup{
        style="deep",
        transparent=true,
        highlights={
            ["@comment"] = {fg="#aaaaaa"} 
        }
    }
  require'poimandres'.setup {
        bold_vert_split = false, -- use bold vertical separators
        dim_nc_background = false, -- dim 'non-current' window backgrounds
        disable_background = true, -- disable background
        disable_float_background = false, -- disable background for floats
        disable_italics = false, -- disable italics
    }
  require'tokyonight'.setup {
      transparent = true,
      styles = {
          sidebars = "dark",
          floats = "dark",
      },
      on_highlights = function(highlight, colors)
        highlight.Comment = {fg = "#aaaaaa"}
        highlight.LineNr = {bg = "#222233"}
      end
  }
  require'catppuccin'.setup {
      transparent_background = true,
      custom_highlights = function(colors)
        return {
            Comment = {fg = "#aaaaaa"},
            LineNr = {fg = "#ffffff"},
        }
        end,
        integrations={
            treesitter = true,
            markdown = true,
        }
  }
  require'lualine'.setup {
        options = {
            theme='onedark'
        }
    }
  require'barbar'.setup{
        insert_at_end=true
    }
EOF

colorscheme onedark
" colorscheme catppuccin-mocha
" colorscheme tokyonight-night
" colorscheme poimandres

"}}}

" SETTING ----------------------------------------------------------{{{
syntax on

set number
set relativenumber
set cursorline
set shiftwidth=4
set tabstop=4
set expandtab
set scrolloff=10
set incsearch
set guifont=BlexMonoTextNerdFontMono-Regular:h14
set nowrap
set clipboard=unnamed
set laststatus=2 " for lightline.vim
let mapleader = " "

"vvv Work around https://github.com/fannheyward/coc-rust-analyzer/issues/1113
autocmd FileType * setlocal foldmethod=expr
autocmd FileType rust setlocal foldmethod=indent
autocmd FileType markdown :IndentLinesDisable
let g:vim_markdown_auto_extension_ext = 'mdx'

augroup tex_configs
    autocmd FileType tex :IndentLinesDisable
    autocmd FileType tex setlocal spell
    autocmd FileType tex setlocal foldmethod=expr
    autocmd FileType tex setlocal foldexpr=vimtex#fold#level(v:lnum)
    autocmd FileType tex setlocal foldtext=vimtex#fold#text()
    autocmd FileType tex nnoremap <S-K> :<CR>
augroup end

set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
:au VimLeave * set guicursor=a:ver25-blinkon2
" }}}

" VIMSCRIPTS ----------------------------------------------------------{{{
augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup end
augroup whatever
  autocmd!
  if has('nvim')
    autocmd FileType jsonc,json :IndentLinesDisable
    autocmd BufLeave,BufUnload,BufDelete,BufHidden jsonc,json :IndentLinesEnable
  endif
augroup END
" }}}

" COC ----------------------------------------------------------{{{

let g:coc_global_extensions = [
\   'coc-css',
\   'coc-json',
\   'coc-pyright',
\   'coc-rust-analyzer',
\   'coc-yaml',
\   'coc-eslint',
\   'coc-prettier',
\   'coc-tsserver',
\   'coc-ultisnips',
\   '@yaegassy/coc-tailwindcss3',
\ ]

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use \h to show documentation in preview window
nnoremap <S-K> :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('\h', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>af  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
nnoremap <silent> <leader>f :Format<CR>

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
nnoremap <silent> <leader>m :OR<CR>

nmap <C-b> :NERDTreeToggle<CR>
nmap <leader><CR> :vert sb #<CR>
nmap <leader>k :bnext<CR>
nmap <leader>j :bprevious<CR>
nmap <leader>q :bnext <bar> bdelete #<CR>
nmap <leader>l :vsplit term://powershell <CR>
let g:NERDCreateDefaultMappings = 0
" vnoremap <leader>cc :call nerdcommenter#Comment('x','toggle')<CR>
tnoremap <C-[> <C-\><C-n>

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" }}}


" TREESITTER --- {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"lua","c","python","rust","javascript","typescript"},
    highlight={enable=true},
    indent={enable=true},
}
-- vim.treesitter.language.register('markdown', 'mdx')
EOF

"}}}

