carregaArquivo:-
	consult('./data/livros.pl'). 

adicionaLivro(Titulo,Autor,Editora,Estado):-
	asserta(livro(Titulo,Autor,Editora,Estado)).

adicionaAlugado(Titulo):-
	livro(Titulo,Autor,Editora,D), 
	D == disponivel,
	adicionaLivro(Titulo,Autor,Editora,alugado),
	excluiLivro(Titulo,disponivel), !.

salva:-
	tell('./data/livros.pl'),
	listing(livro),
	told.

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
