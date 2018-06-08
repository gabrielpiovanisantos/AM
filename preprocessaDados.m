function [D, D2] = preprocessaDados(D)
    % Copio os dados originais, pois preciso saber os indices dos atributos
    % faltantes.
    X = D;
    % Zero os valores faltantes pois senao todos os calculos resultantes
    % serao NaN.
    X(isnan(X)) = 0;
    % Utilizo KNN para popular os atributos faltantes. O KNN retorna a
    % media do valor dos N vizinhos.
    for i = 1:size(X, 2)
        % Pego os indices dos elementos que possuem atributo faltante nesta
        % coluna.
        indTeste = find(isnan(D(:, i)));
        % O restante entra como conjunto de treino para predicao do
        % atributo faltante dessa coluna. Pego todas as amostras que
        % possuem o atributo.
        conjuntoTreino = X(~isnan(D(:, i)), :);
        % O rotulo eh o valor dessa coluna.
        rotuloTreino = conjuntoTreino(:, i);
        % Removo o rotulo do conjunto de treino.
        conjuntoTreino(:, i) = [];
        % Prediz o valor faltante para todas as amostras do conjunto de
        % teste.
        for j = 1:size(indTeste, 1)
            % Pego os atributos da amostra faltante.
            amostra = X(indTeste(j), :);
            % Removo o atributo a ser predito, que eh NaN.
            amostra(:, i) = [];
            % Prediz o valor da amostra.
            [predicao, ~] = knnAvg(amostra, conjuntoTreino, rotuloTreino, 3);
            % Atualizo o valor da amostra de X com a predicao.
            X(indTeste(j), i) = predicao;
        end
    end
    
    % Normalizo X.
    [X, ~, ~] = normalizar(X);
    D2 = X;
    % Realizo uma regressao multivariavel para cada coluna, onde a base
    % de treinamento sao todas as amostras que possuem o atributo
    % equivalente daquela coluna, para que entao os atributos das amostras
    % faltantes sejam previstos, visando eliminar resultados repetidos
    % obtidos no KNN.
    for i = 1:size(X, 2)
        % Pego os indices dos elementos que possuem atributo faltante nesta
        % coluna.
        indTeste = find(isnan(D(:, i)));
        % O restante entra como conjunto de treino para predicao do
        % atributo faltante dessa coluna. Pego todas as amostras que
        % possuem o atributo.
        conjuntoTreino = X(~isnan(D(:, i)), :);
        % O rotulo eh o valor dessa coluna.
        rotuloTreino = conjuntoTreino(:, i);
        % Removo o rotulo do conjunto de treino.
        conjuntoTreino(:, i) = [];
        % Insere um para o theta0.
        conjuntoTreino = [ones(size(conjuntoTreino, 1), 1), conjuntoTreino];
        theta = zeros(1, size(conjuntoTreino, 2));
        
        % Computo o custo para popular o valor inicial de theta. Caso ja
        % tenha computado alguma vez passada, carrega ao inves de computar
        % denovo.
        if(~exist(['theta_col', num2str(i), '.mat'], 'file'))
            computarCustoMulti(conjuntoTreino, rotuloTreino, theta);
            % Numero de iteracoes e alpha para o gradiente descendente. 
            iteracoes = 10000;
            alpha = 0.01;
            [theta, ~] = gradienteDescenteMulti(conjuntoTreino, ...
                rotuloTreino, theta, alpha, iteracoes);
            save(['theta_col', num2str(i), '.mat'], 'theta');
        else
            load(['theta_col', num2str(i), '.mat']);
        end
        
        % Agora ja possuo os valores de theta para predizer os atributos
        % faltantes no conjunto de teste.
        for j = 1:size(indTeste, 1)
            % Pego os atributos da amostra faltante.
            amostra = X(indTeste(j), :);
            % Removo o atributo a ser predito, que eh NaN.
            amostra(:, i) = [];
            % Prediz o valor da amostra.
            predicao = sum([1, amostra] .* theta);
            %fprintf("Predicao %f.\n", predicao);
            % Atualizo o valor da amostra de X com a predicao.
            X(indTeste(j), i) = predicao;
        end
    end
    % Atualizo a base de dados com a base normalizada e completa.
    D = X;
end
