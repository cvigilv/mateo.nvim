" Vim syntax file
" Language: SMILES strings
" Maintainer: Noel O'Boyle
" Latest Revision: 16 June 2016

if exists("b:current_syntax")
  finish
endif

syn match smiTitle /\v\s+.*$/hs=s+1
syn match smiString "\v^\S*" nextgroup=smiTitle skipwhite
syn match smiComment "\v^#.*$"

let b:current_syntax = "smi"

hi def link smiComment     Comment
hi def link smiString      Identifier
hi def link smiTitle       Include
