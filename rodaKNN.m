% Funcao roda o knn com K ate o K fornecido, ou seja, se for fornecido k =
% 11, os testes feitos serao com k = 1,3,5,7,9,11. O retorno sera um cell
% contendo o resultado do KNN, ou seja, dado o exemplo, teriamos no indice
% 1 do cell array os resultados do k = 1, e assim por diante.
function knnsTeste = rodaKNN(conjuntoTreino, rotulosTreino, conjuntoTeste, k)
    addpath('./KNN/');
    testes = 1:2:k;
    knnsTeste = cell(length(testes));
    count = 1;
    % Faco a classificacao do conjunto de testes.
    fprintf('Inicio da classificacao KNN com Ks = ');
    fprintf('%d, ', testes);
    fprintf('\n');
    indices = zeros(length(conjuntoTeste), k);
    tic;
    for i = 1:length(conjuntoTeste)
        [~, indice] = knn(conjuntoTeste(i, :), conjuntoTreino, rotulosTreino, k);
        indices(i, :) = indice;
    end
    toc;
    disp('Termino da classificacao KNN.');
    
    for i = testes
        ind_temp = indices(:, 1:i);
        tam = size(ind_temp, 1);
        classe = zeros(tam, 1);
        for j = 1:tam
            classe(j, 1) = mode(rotulosTreino(ind_temp(j, 1:i)));
        end
        knnsTeste{count} = classe;
        count = count + 1;
    end
end