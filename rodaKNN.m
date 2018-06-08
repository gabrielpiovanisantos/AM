% Funcao roda o knn para todos os Ks em 'testes'. A funcao aceita 2 ou 3
% conjuntos, se forem 2 conjuntos, conjuntoVal e rotuloVal tem que ser
% igual a 0, sendo que isso fara com que a funcao nao rode considerando o
% conjunto de validacao, logo 'knnsVal' sera 0;
%
function [knnsTeste, knnsVal] = rodaKNN(conjuntoTreino, rotulosTreino, conjuntoTeste, conjuntoVal)
    testes = [1 3 5 7 9 11 13 15 17 19 21 23 25]; 
    knnsTeste = cell(length(testes));
    if(length(conjuntoTeste) == 1)
        knnsVal = 0;
    else
        knnsVal = cell(length(testes));
    end
    count = 1;
    % Faco a classificacao do conjunto de testes.
    disp('Inicio da classificacao usando KNN no conjunto de testes.')
    for i = 1:length(testes)
        fprintf('Inicio do calculo com K = %d.\n', testes(i));
        classes = zeros(length(conjuntoTreino), 1);
        indices = zeros(length(conjuntoTreino), testes(i));
        tic;
        for j = 1:length(conjuntoTreino)
            [classe, indice] = knn(conjuntoTeste(j, :), conjuntoTreino, rotulosTreino, testes(i));
            classes(j, 1) = classe;
            indices(j, :) = indice;
        end
        toc;
        fprintf('Termino do calculo com K = %d.\n', testes(i));
        knnsTeste{count} = [classes indices];
        count = count + 1;
    end
    % Se for fornecido, faz os testes com o conjunto de validacao.
    if(length(conjuntoTeste) == 1)
        count = 1;
        disp('Inicio da classificacao usando KNN no conjunto de testes.')
        for i = 1:length(testes)
            fprintf('Inicio do calculo com K = %d.\n', testes(i));
            classes = zeros(length(conjuntoTreino), 1);
            indices = zeros(length(conjuntoTreino), testes(i));
            tic;
            for j = 1:length(conjuntoTreino)
                [classe, indice] = knn(conjuntoVal(j, :), conjuntoTreino, rotulosTreino, testes(i));
                classes(j, 1) = classe;
                indices(j, :) = indice;
            end
            toc;
            fprintf('Termino do calculo com K = %d.\n', testes(i));
            knnsVal{count} = [classes indices];
            count = count + 1;
        end
    end
end