" I'm using ALE, so I don't want things to conflict
let g:lsp_diagnostics_enabled = 0

" Try out highlighting with a big delay.
let g:lsp_highlight_references_enabled = 1
" This cannot be modified at runtime.
let g:lsp_diagnostics_highlights_delay = 4000
let g:lsp_diagnostics_signs_delay = 4000
let g:lsp_document_highlight_delay = 4000
" Prevents completion from starting after . or ->
let g:asyncomplete_min_chars = 2

"~ let g:lsp_log_verbose = 1
let g:lsp_log_file = g:david_cache_root .'/lsp.log'

" To make lsp replace ALE:
"~ let g:lsp_diagnostics_enabled = 1
"~ let g:lsp_signs_enabled = 1         " enable signs
"~ let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
"~ let g:lsp_signs_error = {'text': '✗'}
"~ let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
"~ let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI

" Default omnifunc to lsp.
set omnifunc=lsp#complete

" vim-lsp doesn't do anything smart to find what to hover, so make our own.
command! HoverUnderCursor LspHover expand('<cword>')

let g:lsp_settings = {}
let g:lsp_settings['omnisharp-lsp'] = {}
" See after_lsp.vim

augroup david_lsp
    au!

    " # lua-lsp
    " brew install luarocks
    "   or
    " scoop install luarocks # also requires visual studio for cl.exe
    " luarocks install luacheck
    " luarocks install --server=http://luarocks.org/dev lua-lsp
    "
    " # emmylua-ls
    " install openjdk
    " LspInstallServer
    if executable('lua-lsp') || executable(lsp_settings#servers_dir() .'/emmylua-ls/emmylua-ls') || executable(lsp_settings#servers_dir() .'/sumneko-lua-language-server/sumneko-lua-language-server')
        let g:lua_define_omnifunc = 0
        let g:lua_define_completion_mappings = 0
        if executable('lua-lsp')
            au User lsp_setup call lsp#register_server({
                        \ 'name': 'lua-lsp',
                        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'lua-lsp']},
                        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'main.lua'))},
                        \ 'whitelist': ['lua'],
                        \ })
        endif
        " vim-lsp-settings handles setup for emmylua
    endif

    " pip install python-language-server
    " vim-lsp-settings handles setup for pyls

    " brew cask install godot
    if executable('/Applications/Godot.app/Contents/MacOS/Godot')
        au User lsp_setup 
                    \ call lsp#register_server({
                    \ 'name': 'godot',
                    \ 'cmd': ["nc", "localhost", "6008"],
                    \ 'allowlist': ['gdscript3', 'gdscript']
                    \ })
    endif
augroup END
