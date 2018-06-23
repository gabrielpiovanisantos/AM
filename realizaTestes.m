% Esta funcao realiza todos os testes dos classificadores, retornando as
% informacoes dos testes em uma cell array. As metricas utilizadas foram a
% acuracia e a fmedida. Como o conjunto de dados esta bem desbalanceado,
% temos que considerar como maior peso apenas a fmedida da base negativa.
%       
% As entradas sao:
%   conjuntoDados - O conjunto de dados a ser testado, sem a coluna de
%       classes.
%   rotulos - Os rotulos das amostras em conjuntoDados.
%       
function realizaTestes(conjuntoDados, rotulos, rKnn, rRna, rSvm, rRegLog)
    % O retorno sera uma cell array que contera o resultado de cada
    % algoritmo em cada indice. Segue o indice e o algoritmo:
    %   knn                     - 1
    %   regressao logistica     - 2
    %   rede neural artificial  - 3
    %   svm                     - 4
    
    % Concateno os rotulos com suas amostras temporariamente para realizar
    % a divisao.
    conDadosCompleto = [conjuntoDados, rotulos];
    
    % Preciso garantir as proporcoes das classes, por isso eh necessario
    % dividir o conjunto em classe 0 e 1 para que depois cada teste tenha a
    % proporcao adequada de cada classe.
    conDadosCompletoZero = conDadosCompleto(conDadosCompleto(:, 65) == 0, :);
    conDadosCompletoUm = conDadosCompleto(conDadosCompleto(:, 65) == 1, :);
    
    % Agora preparo o conjunto para os k testes.
    % Quantidade de subconjuntos para os testes.
    k = 10; 
    % Agora divido o conjunto em k. divZero ira conter k indices, cada um
    % contendo um subconjunto apenas de amostras da classe zero.
    divZero = divideMatriz(conDadosCompletoZero, (zeros(1, k) + k)/100);
    % divUm ira conter k indices, cada um contendo um subconjunto apenas de
    % amostras da classe um.
    divUm = divideMatriz(conDadosCompletoUm, (zeros(1, k) + k)/100);
    % Finalmente crio os subconjuntos. As cell arrays 'conjunto' e
    % 'rotulos' representam um conjunto, ou seja, o subconjunto k = 1 eh
    % representado por conjunto{1} e rotulos{1}.
    conjunto = cell(1, k);
    rotulos = cell(1, k);
    for i = 1:k
        c = [divZero{i}; divUm{i}];
        conjunto{i} = c(:, 1:64);
        rotulos{i} = c(:, 65);
    end
    
    % Realizo os testes k-fold do KNN. Para o processamento do resultado,
    % preciso salvar todas as variaveis retornadas
    % Os Ks a ser testados
    if(rKnn == 1)
        knn_k = 25; % Ate qual k vai ser testado
        knn_k_vet = 1:2:knn_k;
        knn_matriz_conf = zeros(size(knn_k_vet, 2), 3, k);
        for i = 1:k
            fprintf('Realizando o KNN no subconjunto k = %d.\n', i);
            conjuntoTeste = conjunto{i};
            rotulosTeste = rotulos{i};
            conjuntoTreino = 0;
            rotulosTreino = 0;
            for j = 1:k
                if(j ~= i)
                    if(conjuntoTreino == 0)
                        conjuntoTreino = conjunto{j};
                        rotulosTreino = rotulos{j};
                    else
                        conjuntoTreino = [conjuntoTreino; conjunto{j}];
                        rotulosTreino = [rotulosTreino; rotulos{j}];
                    end
                end
            end
            % Calculo o KNN ate o K = 25.
            knnsTeste = rodaKNN(conjuntoTreino, rotulosTreino, conjuntoTeste, knn_k);
            % Extraio os resultados e salvo em knn_matriz_conf.
            for j = 1:size(knn_k_vet, 2)
                [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(knnsTeste{j}(:, 1), rotulosTeste);
                % Cada linha em knn_matriz_conf contera os resultados do knn
                % com o subconjunto k, ou seja, com k = 10, teremos 10 x 7.
                knn_matriz_conf(j, :, i) = [acu, fmedidaPos, fmedidaNeg];
            end
        end
        % Agora possuo todos os resultados em knn_matriz_conf, calculo o desvio
        % padrao e a media das metricas devido ao k-fold.
        mediaKnn = mean(knn_matriz_conf, 3);
        dsvpKnn = std(knn_matriz_conf, [], 3);
        % Exibo os resultados obtidos.
        for i = 1:size(knn_k_vet, 2)
            fprintf('Resultado do KNN com K = %d:\n', knn_k_vet(i));
            fprintf('\tMedia: F-Medida(Pos: %f Neg: %f) Acuracia: %f\n', ...
                mediaKnn(i, 2), mediaKnn(i, 3), mediaKnn(i, 1));
            fprintf('\tDesvio Padrao: F-Medida(Pos: %f Neg: %f) Acuracia: %f\n', ...
                dsvpKnn(i, 2), dsvpKnn(i, 3), dsvpKnn(i, 1));
        end
    end
    % Realizo os testes com a rede neural.
    % Inicializo a matriz que ira conter os resultados dos testes com a
    % rede neural.
    if(rRna == 1)
        num_redes = 10; % Num de redes a serem testadas
        camadas_hidden = cell(1, num_redes);
        camadas_hidden{1} = 32;
        camadas_hidden{2} = 64;
        camadas_hidden{3} = [32 32];
        camadas_hidden{4} = [64 64];
        camadas_hidden{5} = [32 32 32];
        camadas_hidden{6} = [64 64 64];
        camadas_hidden{7} = [128 64 32];
        camadas_hidden{8} = [64 64 32];
        camadas_hidden{9} = [32 32 32 32];
        camadas_hidden{10} = [64 64 64 64];
        resultado_rna = zeros(num_redes, 3, k); % Aqui estara os resultados
        for i = 1:k
            fprintf('Realizando o teste da Rede Neural no subconjunto k = %d.\n', i);
            % Crio o conjunto k atual
            conjuntoTeste = conjunto{i};
            rotulosTeste = rotulos{i};
            conjuntoTreino = 0;
            rotulosTreino = 0;
            % Crio o conjunto de treino, ou seja, todos os outros k.
            for j = 1:k
                if(j ~= i)
                    if(conjuntoTreino == 0)
                        conjuntoTreino = conjunto{j};
                        rotulosTreino = rotulos{j};
                    else
                        conjuntoTreino = [conjuntoTreino; conjunto{j}];
                        rotulosTreino = [rotulosTreino; rotulos{j}];
                    end
                end
            end
            % Testo uma rede neural com uma camada e metade dos neuronios
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, 32, 1);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(1, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com uma camada e todos os neuronios
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, 64, 1);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(2, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com duas camadas e metade dos neuronios
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, [32 32], 0.1);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(3, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com duas camadas e todos os neuronios
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, [64 64], 0.1);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(4, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com tres camadas e metade dos neuronios
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, [32 32 32], 0.01);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(5, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com tres camadas e todos os neuronios
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, [64 64 64], 0.01);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(6, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com tres camadas, todas com tamanho
            % diferente
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, [128 64 32], 0.01);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(7, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com tres camadas, duas com todos os
            % neuronios e a ultima com metade
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, [64 64 32], 0.01);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(8, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com 4 camadas com metade dos neuronios
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, [32 32 32 32], 0.00001);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(9, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testo uma rede neural com 4 camadas com todos os neuronios
            [pred, ~] = rodaRedeNeural(conjuntoTreino, rotulosTreino, ...
                conjuntoTeste, rotuloTeste, [64 64 64 64], 0.00001);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_rna(10, :, k) = [acu, fmedidaPos, fmedidaNeg];
        end

        % Agora calculo a media dos ks do k-fold e o desvio padrao
        mediaRna = mean(resultado_rna, 3);
        dsvpRna = std(resultado_rna, [], 3);
        % Exibo os resultados obtidos.
        for i = 1:num_redes
            fprintf('Resultado da Rede Neural com as camadas hidden de tamanho [');
            fprintf('%d', camadas_hidden{i});
            fprintf(']:\n');
            fprintf('\tMedia: F-Medida(Pos: %f Neg: %f) Acuracia: %f\n', ...
                mediaRna(i, 2), mediaRna(i, 3), mediaRna(i, 1));
            fprintf('\tDesvio Padrao: F-Medida(Pos: %f Neg: %f) Acuracia: %f\n', ...
                dsvpRna(i, 2), dsvpRna(i, 3), dsvpRna(i, 1));
        end
    end
    % Agora realizo os testes com o SVM.
    if(rSvm == 1)
        num_svms = 10;
        resultado_svm = zeros(num_svms, 3, k);
        for i = 1:k
            fprintf('Realizando o teste do SVM no subconjunto k = %d.\n', i);
            % Crio o conjunto k atual
            conjuntoTeste = conjunto{i};
            rotulosTeste = rotulos{i};
            conjuntoTreino = 0;
            rotulosTreino = 0;
            % Crio o conjunto de treino, ou seja, todos os outros k.
            for j = 1:k
                if(j ~= i)
                    if(conjuntoTreino == 0)
                        conjuntoTreino = conjunto{j};
                        rotulosTreino = rotulos{j};
                    else
                        conjuntoTreino = [conjuntoTreino; conjunto{j}];
                        rotulosTreino = [rotulosTreino; rotulos{j}];
                    end
                end
            end
            % A chamada do rodaSVM eh (c, g, t, w0, w1 ...
            % Testando com c = 10000 e kernel sigmoide sem peso
            [pred, ~, ~] = rodaSVM(10000, 3, 0.07, 1, 1, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(1, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 10000 e kernel sigmoide com peso
            [pred, ~, ~] = rodaSVM(10000, 3, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(2, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 10000 e kernel radial com peso
            [pred, ~, ~] = rodaSVM(10000, 2, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(3, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 10000 e kernel polinomial com peso
            [pred, ~, ~] = rodaSVM(10000, 1, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(4, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 10000 e kernel linear com peso
            [pred, ~, ~] = rodaSVM(10000, 0, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(5, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 1000 e kernel sigmoide com peso
            [pred, ~, ~] = rodaSVM(1000, 3, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(6, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 1000 e kernel radial com peso
            [pred, ~, ~] = rodaSVM(1000, 2, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(7, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 1000 e polinomial sigmoide com peso
            [pred, ~, ~] = rodaSVM(1000, 1, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(8, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 1000 e kernel linear com peso
            [pred, ~, ~] = rodaSVM(1000, 0, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(9, :, k) = [acu, fmedidaPos, fmedidaNeg];
            % Testando com c = 1 e kernel sigmoide com peso
            [pred, ~, ~] = rodaSVM(1, 3, 0.07, 1, 2, ...
                conjuntoTreino, rotulosTreino, conjuntoTeste, rotulosTeste);
            [acu, ~, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulosTeste);
            resultado_svm(10, :, k) = [acu, fmedidaPos, fmedidaNeg];
        end
        
        % Agora calculo a media dos ks do k-fold e o desvio padrao do svm
        mediaSvm = mean(resultado_svm, 3);
        dsvpSvm = std(resultado_svm, [], 3);
        % Exibo os resultados obtidos.
        for i = 1:num_redes
            fprintf('Resultado do SVM %d:', i);
            fprintf('\tMedia: F-Medida(Pos: %f Neg: %f) Acuracia: %f\n', ...
                mediaSvm(i, 2), mediaSvm(i, 3), mediaSvm(i, 1));
            fprintf('\tDesvio Padrao: F-Medida(Pos: %f Neg: %f) Acuracia: %f\n', ...
                dsvpSvm(i, 2), dsvpSvm(i, 3), dsvpSvm(i, 1));
        end
    end
end