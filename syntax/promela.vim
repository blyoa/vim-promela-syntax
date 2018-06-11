" Vim syntax file
" Language:			ProMeLa
" Original Maintainer:		Maurizio Tranchero <maurizio.tranchero@polito.it> - <maurizio.tranchero@gmail.com>
" NOTE:		This script is modified from the original after the initial commit (f5882f10ce).
"
" This syntax file is based on:
" - $VIMRUNTIME/syntax/c.vim       (Last Change: Mar 05, 2015)
" - $VIMRUNTIME/syntax/promela.vim (Last Change: Aug 07, 2008)

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Keywords
syn keyword promelaStructure  D_proctype proctype init inline never trace notrace
syn keyword promelaModifier    active hidden provided
syn keyword promelaOperator    run
syn keyword promelaConditional  if fi select
syn keyword promelaRepeat    do od while for unless
syn keyword promelaStatement  atomic d_step show
syn keyword promelaStatement  else skip timeout
syn keyword promelaStatement  break goto
syn keyword promelaStatement  xr xs
syn keyword promelaStatement  c_code c_decl c_expr c_state c_track
syn keyword promelaFunction    assert empty enabled full get_priority len nempty nfull pc_value printf set_priority
syn keyword promelaKeyword    ltl
syn keyword promelaIdentifier _ _pid _nr_pr np_ _last STDIN
syn keyword promelaTodo         contained TODO FIXME XXX

" Types
syn keyword promelaTypedef    typedef
syn keyword promelaType      bit bool byte short int chan mtype

" Operators and special characters
syn match promelaOperator  "!"
syn match promelaOperator  "?"
syn match promelaOperator  "="
syn match promelaOperator  "+"
syn match promelaOperator  "*"
syn match promelaOperator  "/"
syn match promelaOperator  "-"
syn match promelaOperator  "<"
syn match promelaOperator  ">"
syn match promelaOperator  "<="
syn match promelaOperator  ">="
syn match promelaOperator  "=="
syn match promelaOperator  "||"
syn match promelaOperator  "&&"
syn match promelaOperator  "@"
syn match promelaOption    "::"
syn match promelaDelimiter  ";"
syn match promelaDelimiter  "->"

" Constants
" boolean
syn keyword promelaBoolean true false
" number
syn match promelaNumber "\<\d\+\([Ee]\d\+\)\?\>"
" string
syn match promelaSpecial "\\."
syn region promelaString start=+"+ skip=+\\\\\|\\"+ end=+"\|$+ contains=promelaSpecial

" Parenthesis
syn region promelaParen transparent start='(' end=')' contains=ALLBUT,@promelaCppOutInGroup,promelaIncluded,promelaLabel,@Spell

" Preprocessor
" if/ifdef
syn region  promelaPreCondit      start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=promelaComment,promelaString,promelaParen,promelaNumber
syn match   promelaPreConditMatch display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
syn cluster promelaCppOutInGroup  contains=promelaCppInIf,promelaCppInElse,promelaCppInElse2,promelaCppOutIf,promelaCppOutIf2,promelaCppOutElse,promelaCppInSkip,promelaCppOutSkip
syn region  promelaCppOutWrapper  start="^\s*\(%:\|#\)\s*if\s\+0\+\s*\($\|//\|/\*\|&\)" end=".\@=\|$" contains=promelaCppOutIf,promelaCppOutElse,@NoSpell fold
syn region  promelaCppOutIf       contained start="0\+" matchgroup=promelaCppOutWrapper end="^\s*\(%:\|#\)\s*endif\>" contains=promelaCppOutIf2,promelaCppOutElse
syn region  promelaCppOutIf2      contained matchgroup=promelaCppOutWrapper start="0\+" end="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0\+\s*\($\|//\|/\*\|&\)\)\@!\|endif\>\)"me=s-1 contains=promelaCppOutSkip,@Spell fold
syn region  promelaCppOutElse     contained matchgroup=promelaCppOutWrapper start="^\s*\(%:\|#\)\s*\(else\|elif\)" end="^\s*\(%:\|#\)\s*endif\>"me=s-1 contains=TOP,promelaPreCondit
syn region  promelaCppInWrapper   start="^\s*\(%:\|#\)\s*if\s\+0*[1-9]\d*\s*\($\|//\|/\*\||\)" end=".\@=\|$" contains=promelaCppInIf,promelaCppInElse fold
syn region  promelaCppInIf        contained matchgroup=promelaCppInWrapper start="\d\+" end="^\s*\(%:\|#\)\s*endif\>" contains=TOP,promelaPreCondit
syn region  promelaCppInElse      contained start="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0*[1-9]\d*\s*\($\|//\|/\*\||\)\)\@!\)" end=".\@=\|$" containedin=promelaCppInIf contains=promelaCppInElse2 fold
syn region  promelaCppInElse2     contained matchgroup=promelaCppInWrapper start="^\s*\(%:\|#\)\s*\(else\|elif\)\([^/]\|/[^/*]\)*" end="^\s*\(%:\|#\)\s*endif\>"me=s-1 contains=promelaCppOutSkip,@Spell
syn region  promelaCppOutSkip     contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=promelaCppOutSkip
syn region  promelaCppInSkip      contained matchgroup=promelaCppInWrapper start="^\s*\(%:\|#\)\s*\(if\s\+\(\d\+\s*\($\|//\|/\*\||\|&\)\)\@!\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" containedin=promelaCppOutElse,promelaCppInIf,promelaCppInSkip contains=TOP,promelaPreProc

" include/define/pragma...
syn region  promelaIncluded     display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match   promelaIncluded     display contained "<[^>]*>"
syn match   promelaInclude      display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=promelaIncluded
syn cluster promelaPreProcGroup contains=promelaPreCondit,promelaIncluded,promelaInclude,promelaDefine,promelaLabel,promelaSpecial,promelaCppOutWrapper,promelaCppInWrapper,promelaComment,@promelaCppOutInGroup
syn region  promelaDefine       start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@promelaPreProcGroup,@Spell
syn region  promelaPreProc      start="^\s*\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend contains=ALLBUT,@promelaPreProcGroup,@Spell

" Label
syn cluster promelaLabelGroup contains=promelaLabel
syn match   promelaUserCont   display "^\s*\I\i*\s*:$" contains=@promelaLabelGroup
syn match   promelaUserCont   display ";\s*\I\i*\s*:$" contains=@promelaLabelGroup
syn match   promelaUserCont   display "^\s*\I\i*\s*:[^:]"me=e-1 contains=@promelaLabelGroup
syn match   promelaUserCont   display ";\s*\I\i*\s*:[^:]"me=e-1 contains=@promelaLabelGroup
syn match   promelaLabel      display "\I\i*" contained

" Comments
syn region promelaComment start="/\*" end="\*/" contains=promelaTodo,@Spell
syn match  promelaComment "//.*" contains=promelaTodo,@Spell

" Class Linking
hi def link promelaIdentifier     Identifier
hi def link promelaKeyword        Keyword
hi def link promelaModifier       StorageClass
hi def link promelaStructure      Structure
hi def link promelaStatement      Statement
hi def link promelaFunction       Function
hi def link promelaConditional    Conditional
hi def link promelaRepeat         Repeat
hi def link promelaLabel          Label
hi def link promelaTypedef        Typedef
hi def link promelaType           Type
hi def link promelaComment        Comment
hi def link promelaOperator       Operator
hi def link promelaDelilmiter     Delimiter
hi def link promelaOption         Label
hi def link promelaSpecial        Special
hi def link promelaString         String
hi def link promelaBoolean        Boolean
hi def link promelaNumber         Number
hi def link promelaConstant       Constant
hi def link promelaTodo           Todo
hi def link promelaPreProc        PreProc
hi def link promelaInclude        Include
hi def link promelaDefine         Macro
hi def link promelaIncluded       String
hi def link promelaCppInWrapper   promelaCppOutWrapper
hi def link promelaCppOutWrapper  promelaPreCondit
hi def link promelaPreConditMatch promelaPreCondit
hi def link promelaPreCondit      PreCondit
hi def link promelaCppInElse2     promelaCppOutIf2
hi def link promelaCppOutSkip     promelaCppOutIf2
hi def link promelaCppOutIf2      Comment

let b:current_syntax = "promela"

let s:cpo_save = &cpo
set cpo&vim
