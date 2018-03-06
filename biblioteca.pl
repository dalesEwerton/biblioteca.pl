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

listaLivrosDisponiveis:-
	livro(Titulo,Autor,Editora,disponivel),
	format('Livro = ~w', [Titulo]),
	format('  Autor = ~w', [Autor]),
	format('  Editora = ~w', [Editora]),
	nl,nl.

salva:-
	tell('./data/livros.pl'),
	listing(livro),
	told.

acao(0):-
	writeln("Programa finalizado"),
	salva.

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

acao(X):-
	writeln("Opção inválida, tente novamente.").
