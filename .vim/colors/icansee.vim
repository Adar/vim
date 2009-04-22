"Vim color file tailored legibility on black background.
"Maintainer:    John Rhee  <jrhee75@gmail.com>
"Last Change:   2005/10/18  v0.1
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let colors_name = "icansee"

hi SpecialKey   term=bold                                         ctermfg=Green
hi NonText      term=bold                                         ctermfg=DarkGreen
hi Directory    term=bold                                         ctermfg=Cyan
hi ErrorMsg     term=standout                     ctermbg=DarkRed ctermfg=White
hi IncSearch    term=reverse        cterm=reverse
hi Search                                         ctermbg=Grey    ctermfg=Black
hi MoreMsg      term=bold                                         ctermfg=Green
hi ModeMsg      term=bold           cterm=bold
hi LineNr       term=underline                                    ctermfg=DarkYellow
hi Question     term=standout                                     ctermfg=Green
hi StatusLine   term=reverse,bold   cterm=reverse
hi StatusLineNC term=reverse        cterm=reverse
hi VertSplit    term=reverse        cterm=reverse
hi Title        term=bold                                         ctermfg=DarkGrey
hi Visual       term=reverse        cterm=reverse
hi VisualNOS    term=bold,underline cterm=bold,underline
hi WarningMsg   term=standout                                     ctermfg=Red
hi Folded       term=standout                     ctermbg=black   ctermfg=DarkBlue
hi FoldColumn   term=standout                                     ctermfg=242
hi Normal                                         ctermbg=235     ctermfg=39
hi Comment      term=bold                                         ctermfg=LightGray
hi Constant     term=underline                                    ctermfg=DarkGreen
hi Special      term=bold                                         ctermfg=LightCyan
hi Identifier   term=underline                                    ctermfg=Cyan
hi Statement    term=bold                                         ctermfg=Yellow
hi PreProc      term=underline                                    ctermfg=Gray
hi Type                                                           ctermfg=Green
hi Underlined   term=underline      cterm=underline               ctermfg=Red
hi Ignore                                                         ctermfg=Black
hi Error    term=reverse        ctermbg=Red                       ctermfg=White
hi Todo     term=standout       ctermbg=DarkYellow                ctermfg=Black
