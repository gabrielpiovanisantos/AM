% Esta funcao realiza todos os testes dos classificadores, o retorno deve
% ser:
%   Precisao - calculada da forma:
%       Precisao = (C / X), onde
%           C = numero de amostras que foram classificadas corretamente
%           X = numero total de amostras
%   Matrix de confusao - calculada da forma:
%       
% As entradas sao:
%   conjuntoDados - O conjunto de dados a ser testado, sem a coluna de
%       classes.
%   rotulos - Os rotulos das amostras em conjuntoDados.
%   porTreino - A porcentagem das amostras de conjuntoDados que serao 
%       utilizadas no treino, o restante sera utilizada no teste.
%   divisaoCross - Uma matrix 1x2 contendo a porcentagem de amostras que
%       serao utilizadas no treino e na validacao. O restante sera
%       utilizado no teste.
%       
function [knnsTeste, resultado, resultadoCross] = realizaTestes(conjuntoDados, rotulos, pTreino, divisaoCross)
    % O retorno sera uma cell array que contera o resultado de cada
    % algoritmo em cada indice. Segue o indice e o algoritmo:
    %   knn                     - 1
    %   regressao logistica     - 2
    %   rede neural artificial  - 3
    %   svm                     - 4
    resultado = cell(4, 1);
    resultadoCross = cell(4, 1);
    
    % Reparto meu conjunto de dados em suas classes.
    classeZero = conjuntoDados(rotulos == 0, :);
    classeUm = conjuntoDados(rotulos == 1, :);
    % Valor utilizado para dividir o conjunto de dados dada a porcentagem.
    divUm = int32(floor(pTreino * size(classeUm, 1)));
    divZero = int32(floor(pTreino * size(classeZero, 1)));
    % Divido entao o conjunto de dados em treino e teste.
    conjuntoTreinoUm = classeUm(1:divUm, :);
    conjuntoTreinoZero = classeZero(1:divZero, :);
    conjuntoTesteUm = classeUm((divUm + 1):end, :);
    conjuntoTesteZero = classeZero((divZero + 1):end, :);
    
    conjuntoTreino = [conjuntoTreinoUm; conjuntoTreinoZero];
    rotulosTreino = [ones(size(conjuntoTreinoUm, 1), 1); zeros(size(conjuntoTreinoZero, 1), 1)];
    conjuntoTeste = [conjuntoTesteUm; conjuntoTesteZero];
    rotulosTeste = [ones(size(conjuntoTesteUm, 1), 1); zeros(size(conjuntoTesteZero, 1), 1)];
    
    fprintf('Tamanho do conjunto de treino: %d %d.\n', size(conjuntoTreino, 1));
    fprintf('Tamanho do conjunto de teste: %d %d.\n', size(conjuntoTeste, 1));
    % Realizo o teste utilizando o KNN.
    [knnsTeste, ~] = rodaKNN(conjuntoTreino, rotulosTreino, conjuntoTeste, 0);
end