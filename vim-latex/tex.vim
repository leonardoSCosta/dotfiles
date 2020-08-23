set sw=2
set iskeyword+=:

" Ao digitar refF, refT ou refQ, insere o texto para referenciar uma figura,
" tabela ou equação.

call IMAP('refF', '\ref{fig:<++>}<++>', 'tex')
call IMAP('refT', '\ref{tab:<++>}<++>', 'tex')
call IMAP('refQ', '\eqref{eq:<++>}<++>', 'tex')
