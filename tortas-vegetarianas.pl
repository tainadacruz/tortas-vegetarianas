camiseta(amarela).
camiseta(azul).
camiseta(branca).
camiseta(verde).
camiseta(vermelha).

nome(ana).
nome(carina).
nome(fernanda).
nome(ludmila).
nome(poliana).

torta(abobrinha).
torta(brocolis).
torta(cebola).
torta(ervilha).
torta(mussarela).

suco(abacaxi).
suco(laranja).
suco(maca).
suco(maracuja).
suco(uva).

livro(artes).
livro(biografia).
livro(contos).
livro(cronicas).
livro(religiao).

idade(30).
idade(35).
idade(40).
idade(45).
idade(50).


%X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).

%X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X),
                        nth0(IndexY,Lista,Y),
                        IndexX < IndexY.

%X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista).

%X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

entre(X, Y, Z, Lista) :- aEsquerda(X, Z, Lista),
                         aDireita(X, Y, Lista).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaSolucao) :-

    ListaSolucao = [
        amiga(Camiseta1, Nome1, Torta1, Suco1, Livro1, Idade1),
        amiga(Camiseta2, Nome2, Torta2, Suco2, Livro2, Idade2),
        amiga(Camiseta3, Nome3, Torta3, Suco3, Livro3, Idade3),
        amiga(Camiseta4, Nome4, Torta4, Suco4, Livro4, Idade4),
        amiga(Camiseta5, Nome5, Torta5, Suco5, Livro5, Idade5)
    ],

    %O Ana está na quinta posição.
    Nome5 = ana,

    %0 Fernanda está na quarta posição.
    Nome4 = fernanda,

    %O A mulher de Vermelho está lendo um livro de Crônicas.
    member(amiga(vermelha, _, _, _, cronicas, _), ListaSolucao),

    %O Carina está ao lado da amiga que está comendo torta de Ervilha.
    aoLado(amiga(_, carina, _, _, _, _), amiga(_, _, ervilha, _, _, _), ListaSolucao),

    %O A mulher de 45 anos está ao lado da mulher que está comendo torta de Abobrinha.
    aoLado(amiga(_, _, _, _, _, 45), amiga(_, _, abobrinha, _, _, _), ListaSolucao),

    %0 A amiga que está comendo torta de Ervilha está ao lado da amiga de 50 anos.
    aoLado(amiga(_, _, _, _, _, 50), amiga(_, _, ervilha, _, _, _), ListaSolucao),

    %0 A amiga que está comendo a torta de Cebola está ao lado da amiga que está bebendo suco de Maçã.
    aoLado(amiga(_, _, cebola, _, _, _), amiga(_, _, _, maca, _, _), ListaSolucao),

    %0 A mulher mais nova está ao lado da mulher de camiseta Vermelha.
    aoLado(amiga(_, _, _, _, _, 35), amiga(vermelha, _, _, _, _, _), ListaSolucao),

    %0 A mulher que está comendo torta de Mussarela está exatamente à esquerda da mulher que está bebendo suco de Abacaxi.
    aoLado(amiga(_, _, mussarela, _, _, _), amiga(_, _, _, abacaxi, _, _), ListaSolucao),
    aEsquerda(amiga(_, _, mussarela, _, _, _), amiga(_, _, _, abacaxi, _, _), ListaSolucao),

    %0 A amiga de camiseta Amarela está em algum lugar à esquerda da amiga que está lendo um livro de Contos.
    aEsquerda(amiga(amarela, _, _, _, _, _), amiga(_, _, _, _, contos, _), ListaSolucao),

    %O A mulher de Verde está em algum lugar à direita da mulher de Branco. ////////////////////
    aDireita(amiga(verde, _, _, _, _, _), amiga(branca, _, _, _, _, _), ListaSolucao),

    %0 Poliana está em algum lugar à direita da mulher de Azul.
    aDireita(amiga(_, poliana, _, _, _, _), amiga(azul, _, _, _, _, _), ListaSolucao),

    %O Em uma das pontas está a amiga que está bebendo suco de Maçã.
    noCanto(amiga(_, _, _, maca, _, _), ListaSolucao),

    %0 A mulher que está comendo torta de Ervilha está em algum lugar entre a mulher mais velha e a mulher que está comendo torta de Abobrinha, nessa ordem.
    entre(amiga(_, _, ervilha, _, _, _), amiga(_, _, _, _, _, 50), amiga(_, _, abobrinha, _, _, _), ListaSolucao),

    %0 A mulher que está bebendo suco de Uva está em algum lugar entre a mulher de 50 anos e a mulher que está bebendo suco de Maracujá, nessa ordem.
    entre(amiga(_, _, _, uva, _, _), amiga(_, _, _, _, _, 50), amiga(_, _, _, maracuja, _, _), ListaSolucao),

    %0 A mulher de Azul está em algum lugar entre a Ludmila e a mulher que está bebendo suco de Maracujá, nessa ordem.
    entre(amiga(azul, _, _, _, _, _), amiga(_, ludmila, _, _, _, _), amiga(_, _, _, maracuja, _, _), ListaSolucao),

    %0 A amiga de Azul está em algum lugar entre a amiga de Branco e a amiga que está bebendo suco de Maçã, nessa ordem.
    entre(amiga(azul, _, _, _, _, _), amiga(branca, _, _, _, _, _), amiga(_, _, _, maca, _, _), ListaSolucao),

    %0 A mulher de Azul está em algum lugar entre a mulher de 40 anos e a Ana, nessa ordem.
    entre(amiga(azul, _, _, _, _, _), amiga(_, _, _, _, _, 40), amiga(_, ana, _, _, _, _), ListaSolucao),

    %0 A mulher de 45 anos está em algum lugar entre a Ludmila e a mulher de 35 anos, nessa ordem.
    entre(amiga(_, _, _, _, _, 45), amiga(_, ludmila, _, _, _, _), amiga(_, _, _, _, _, 35), ListaSolucao),

    %0 A amiga que está lendo um livro de Artes está em algum lugar entre a amiga que está comendo torta de Mussarela e a amiga que está lendo um livro de Religião, nessa ordem.
    entre(amiga(_, _, _, _, artes, _), amiga(_, _, mussarela, _, _, _), amiga(_, _, _, _, religiao, _), ListaSolucao),

    %Testa todas as possibilidades...
    camiseta(Camiseta1), camiseta(Camiseta2), camiseta(Camiseta3), camiseta(Camiseta4), camiseta(Camiseta5),
    todosDiferentes([Camiseta1, Camiseta2, Camiseta3, Camiseta4, Camiseta5]),

    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),

    torta(Torta1), torta(Torta2), torta(Torta3), torta(Torta4), torta(Torta5),
    todosDiferentes([Torta1, Torta2, Torta3, Torta4, Torta5]),

    suco(Suco1), suco(Suco2), suco(Suco3), suco(Suco4), suco(Suco5),
    todosDiferentes([Suco1, Suco2, Suco3, Suco4, Suco5]),

    livro(Livro1), livro(Livro2), livro(Livro3), livro(Livro4), livro(Livro5),
    todosDiferentes([Livro1, Livro2, Livro3, Livro4, Livro5]),

    idade(Idade1), idade(Idade2), idade(Idade3), idade(Idade4), idade(Idade5),
    todosDiferentes([Idade1, Idade2, Idade3, Idade4, Idade5]),

    maplist(writeln, ListaSolucao).
