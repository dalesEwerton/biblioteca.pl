carregaArquivo:-
    consult('./data/livros.pl'). 

adicionaLivro(Titulo,Autor,Editora,Estado):-
    asserta(livro(Titulo,Autor,Editora,Estado)).

adicionaAlugado(Titulo):-
    livro(Titulo,Autor,Editora,D), 
    D == disponivel,
    adicionaLivro(Titulo,Autor,Editora,alugado),
    excluiLivro(Titulo,disponivel), !.

devolveLivro(Titulo):-
    livro(Titulo,Autor,Editora,D),
    D == alugado,
    adicionaLivro(Titulo,Autor,Editora,disponivel),
    excluiLivro(Titulo,alugado).
    
excluiLivro(Titulo, Estado):-
    retract(livro(Titulo,_,_,Estado)),!.



listaLivrosDisponiveis:-
    consult('./data/livros.pl'),
    livro(Titulo,Autor,Editora,disponivel),
    format('Livro = ~w', [Titulo]),
    format('  Autor = ~w', [Autor]),
    format('  Editora = ~w', [Editora]),
    nl, nl.


listaLivrosAlugados:-
    livro(Titulo,Autor,Editora,alugado),
    format('Livro = ~w', [Titulo]),
    format('  Autor = ~w', [Autor]),
    format('  Editora = ~w', [Editora]),
    nl,nl.

salva:-
    tell('./data/livros.pl'),
    listing(livro),
    told.

acao(0):-
    writeln("Programa finalizado").

acao(1):-
    write('Digite o nome do livro: '),
    read(Titulo),
    write('Digite o autor do livro: '),
    read(Autor),
    write('Digite a editora do livro: '),
    read(Editora),
    adicionaLivro(Titulo,Autor,Editora,disponivel),
    salva,
    nl,
    writeln('Livro adicionado com sucesso'),
    nl.

acao(2):-
    writeln('Digite o nome do livro.'),
    read(Titulo),
    adicionaAlugado(Titulo),
    salva,
    writeln('Livro alugado com sucesso'),
    nl.

acao(3):-
    writeln('Digite o nome do livro.'),
    read(Titulo),
    devolveLivro(Titulo),
    salva,
    writeln('Livro devolvido com sucesso'),
    nl.

acao(4):-
    listaLivrosDisponiveis.

acao(5):-
    listaLivrosAlugados.

acao(6):-
    writeln('Digite o nome do livro.'),
    read(Titulo),
    writeln('Digite o status do livro.("disponivel", "alugado")'),
    read(Estado),
    excluiLivro(Titulo, Estado),
    nl.

menu:-
    
    nl,
    writeln('Bem-Vindo.'),
    repeat,
    writeln('Menu de opcoes:'),
    writeln('1-Adicionar livro a biblioteca'),
    writeln('2-Alugar livro'),
    writeln('3-Devolve Livro'),
    writeln('4-Lista livros disponiveis'),
    writeln('5-Lista livros alugados'),
    writeln('6-Remover um livro do sistema'),
    writeln('Digite 0 para sair'),
    read(Resposta),nl,
    acao(Resposta),
    Resposta =:= 0, !.
    
start:-
    carregaArquivo,
    menu.
    
:-initialization main.
main:-
    
    start.