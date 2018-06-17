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
    
    % Concateno os rotulos com suas amostras temporariamente para realizar
    % a divisao.
    conDadosCompleto = [conjuntoDados, rotulos];
    % Como devo dividor os conjuntos de maneira a manter a proporcao de
    % classes, para que nao se tenha amostras de apenas uma classe no
    % conjunto, tenho que primeiro dividir o conjunto em suas classes.
    conDadosCompletoZero = conDadosCompleto(conDadosCompleto(:, 65) == 0, :);
    conDadosCompletoUm = conDadosCompleto(conDadosCompleto(:, 65) == 1, :);
    % Agora divido esses subconjuntos em pTreino e restante.
    divZero = divideMatriz(conDadosCompletoZero, [pTreino, (1 - pTreino)]);
    divUm = divideMatriz(conDadosCompletoUm, [pTreino, (1 - pTreino)]);
    % O meu conjunto de treino sera a concatenacao do primeiro indice de
    % divZero e divUm, assim mantenho as proporcoes de classes.
    conjuntoTreino = [divZero{1}; divUm{1}];
    conjuntoTeste = [divZero{2}; divUm{2}];
    % Extraio os rotulos dos conjuntos.
    rotulosTreino = conjuntoTreino(:, 65);
    conjuntoTreino(:, 65) = [];
    rotulosTeste = conjuntoTeste(:, 65);
    conjuntoTeste(:, 65) = [];
    
    fprintf('Tamanho do conjunto de treino: %d.\n', size(conjuntoTreino, 1));
    fprintf('Tamanho do conjunto de teste: %d.\n', size(conjuntoTeste, 1));
    % Realizo o teste utilizando o KNN.
    [knnsTeste, ~] = rodaKNN(conjuntoTreino, rotulosTreino, conjuntoTeste, 0);
    save(['knnsTesteConjuntoInicial_', datestr(now, 'dd-mmm-yyyy-HH-MM-SS'), '.mat'], 'knnsTeste');
    
    % Realizo os testes usando 60/20/20.
    divZero = divideMatriz(conDadosCompletoZero, [.6 .2 .2]);
    divUm = divideMatriz(conDadosCompletoUm, [.6 .2 .2]);
    conjuntoTreino = [divZero{1}; divUm{1}];
    conjuntoTeste = [divZero{2}; divUm{2}];
    conjuntoVal = [divZero{3}; divUm{3}];
    rotulosTreino = conjuntoTreino(:, 65);
    conjuntoTreino(:, 65) = [];
    rotulosTeste = conjuntoTeste(:, 65);
    conjuntoTeste(:, 65) = [];
    rotulosVal = conjuntoVal(:, 65);
    conjuntoVal(:, 65) = [];
    
    fprintf('Tamanho do conjunto de treino: %d.\n', size(conjuntoTreino, 1));
    fprintf('Tamanho do conjunto de teste: %d.\n', size(conjuntoTeste, 1));
    fprintf('Tamanho do conjunto de validacao: %d.\n', size(conjuntoVal, 1));
    
    [knnsTeste, knnsVal] = rodaKNN(conjuntoTreino, rotulosTreino, conjuntoTeste, conjuntoVal);
    save(['knnsTesteConjunto_602020_', datestr(now, 'dd-mmm-yyyy-HH-MM-SS'), '.mat'], 'knnsTeste');
    save(['knnsValConjunto_602020_', datestr(now, 'dd-mmm-yyyy-HH-MM-SS'), '.mat'], 'knnsVal');
    
    % Realizo os testes usando 40/20/40.
    divZero = divideMatriz(conDadosCompletoZero, [.4 .2 .4]);
    divUm = divideMatriz(conDadosCompletoUm, [.4 .2 .4]);
    conjuntoTreino = [divZero{1}; divUm{1}];
    conjuntoTeste = [divZero{2}; divUm{2}];
    conjuntoVal = [divZero{3}; divUm{3}];
    rotulosTreino = conjuntoTreino(:, 65);
    conjuntoTreino(:, 65) = [];
    rotulosTeste = conjuntoTeste(:, 65);
    conjuntoTeste(:, 65) = [];
    rotulosVal = conjuntoVal(:, 65);
    conjuntoVal(:, 65) = [];
    
    fprintf('Tamanho do conjunto de treino: %d.\n', size(conjuntoTreino, 1));
    fprintf('Tamanho do conjunto de teste: %d.\n', size(conjuntoTeste, 1));
    fprintf('Tamanho do conjunto de validacao: %d.\n', size(conjuntoVal, 1));
    
    [knnsTeste, knnsVal] = rodaKNN(conjuntoTreino, rotulosTreino, conjuntoTeste, conjuntoVal);
    save(['knnsTesteConjunto_402040_', datestr(now, 'dd-mmm-yyyy-HH-MM-SS'), '.mat'], 'knnsTeste');
    save(['knnsValConjunto_402040_', datestr(now, 'dd-mmm-yyyy-HH-MM-SS'), '.mat'], 'knnsVal');
    
    % Realizo os testes usando 20/20/60.
    divZero = divideMatriz(conDadosCompletoZero, [.2 .2 .6]);
    divUm = divideMatriz(conDadosCompletoUm, [.2 .2 .6]);
    conjuntoTreino = [divZero{1}; divUm{1}];
    conjuntoTeste = [divZero{2}; divUm{2}];
    conjuntoVal = [divZero{3}; divUm{3}];
    rotulosTreino = conjuntoTreino(:, 65);
    conjuntoTreino(:, 65) = [];
    rotulosTeste = conjuntoTeste(:, 65);
    conjuntoTeste(:, 65) = [];
    rotulosVal = conjuntoVal(:, 65);
    conjuntoVal(:, 65) = [];
    
    fprintf('Tamanho do conjunto de treino: %d.\n', size(conjuntoTreino, 1));
    fprintf('Tamanho do conjunto de teste: %d.\n', size(conjuntoTeste, 1));
    fprintf('Tamanho do conjunto de validacao: %d.\n', size(conjuntoVal, 1));
    
    [knnsTeste, knnsVal] = rodaKNN(conjuntoTreino, rotulosTreino, conjuntoTeste, conjuntoVal);
    save(['knnsTesteConjunto_202060_', datestr(now, 'dd-mmm-yyyy-HH-MM-SS'), '.mat'], 'knnsTeste');
    save(['knnsValConjunto_202060_', datestr(now, 'dd-mmm-yyyy-HH-MM-SS'), '.mat'], 'knnsVal');
end