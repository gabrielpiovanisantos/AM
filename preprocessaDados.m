function [D, D2] = preprocessaDados(D)
    % Copio os dados originais.
    X = D;
    % Substituo os dados faltantes por 0.
    X(isnan(X)) = 0;
    % Normalizo X.
    [X, ~, ~] = normalizar(X);
    D2 = X;
    % Realizo uma regressao multivariavel para cada coluna, onde a base
    % de treinamento sao todas as amostras que possuem o atributo
    % equivalente daquela coluna, para que entao os atributos das amostras
    % faltantes sejam previstos.
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
        
        % Computo o custo para popular o valor inicial de theta.
        computarCustoMulti(conjuntoTreino, rotuloTreino, theta);
        
        % Numero de iteracoes e alpha para o gradiente descendente. 
        iteracoes = 10;
        alpha = 0.01;
        [theta, ~] = gradienteDescenteMulti(conjuntoTreino, ...
            rotuloTreino, theta, alpha, iteracoes);
        % Agora ja possuo os valores de theta para predizer os atributos
        % faltantes no conjunto de teste.
        for j = 1:size(indTeste, 1)
            % Transformo o indice linear em indice linha x coluna.
            [r, c] = ind2sub(size(D), indTeste(j));
            % Pego os atributos da amostra faltante.
            amostra = X(r, :);
            % Removo o atributo a ser predito, que eh NaN.
            amostra(:, i) = [];
            % Prediz o valor da amostra.
            predicao = sum([1, amostra] .* theta);
            %fprintf("Predicao %f.\n", predicao);
            % Atualizo o valor da amostra de X com a predicao.
            X(r, c) = predicao;
        end
    end
    % Atualizo a base de dados com a base normalizada e completa.
    D = X;
end