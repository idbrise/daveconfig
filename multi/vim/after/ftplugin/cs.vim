" C# has:
" 0 indents - namespace
" 1 indents - class
" 2 indents - method
nnoremap <buffer> <C-g><C-g> :<C-u>call david#search#FindScope(2)<CR>

" C# doesn't have useful information in zero column.
call david#mappings#map_next_function_instead_of_zero_column()

" C# code is usually contained within a namespace and a class, so allow for
" more folding depth. (+2)
let &l:foldnestmax = max([g:david_foldnestmax + 2, &l:foldnestmax])

" Blocks of C++-style comments look much better than C-style.
let b:commentary_format = '//~ %s'

setlocal foldmarker=region,endregion

compiler msvc
nnoremap <buffer> <F5> :AsyncMake 

" Don't search tags with basic completion -- it's too slow. insert completion
" should be super fast and mostly ignore context. I can do other
" omnicompletion for smartness (C-x, C-] or C-space).
setlocal complete-=t
setlocal complete-=]

if david#cs#has_omnisharp_server()
    nnoremap <buffer> <Leader>jT :<C-u> TagImposterAnticipateJump <Bar> OmniSharpGotoDefinition<CR>
    nnoremap <buffer> <Leader>jP :<C-u> TagImposterAnticipateJump <Bar> OmniSharpPreviewDefinition<CR>
    " Even with g:omnicomplete_fetch_full_documentation, omnisharp isn't
    " providing any documentation (probably because we don't use ///
    " comments). Not sure why, but the preview window is annoying me (maybe
    " because it opens when there's no content?)
    setlocal completeopt-=preview
    " longest doesn't work and just clears what I've typed so far.
    setlocal completeopt-=longest
else
    " OmniSharp's omnicompletion requires the server to work. If there's no
    " server, use tags instead.
    inoremap <buffer> <C-space> <C-x><C-]>
endif
