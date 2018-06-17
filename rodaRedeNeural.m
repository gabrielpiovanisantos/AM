function pred = rodaRedeNeural(conjuntoTreino, rotulosTreino, conjuntoTeste, rotuloTeste)
    addpath('./RedeNeural/');
    % Variaveis definindo a quantidade de neuronios de cada camada.
    tamCamada = [64, 25, 1];
    numCamadas = length(tamCamada);
    % O primeiro peso deve mapear a camada de entrada para a primeira
    % camada hidden, logo deve ter 65x10, considerando o bias.
    thetaEntrada = inicializaPesosAleatorios(tamCamada(1), tamCamada(2));
    % Depois tenho que iniciar os pesos da camada hidden.
    thetaHidden = cell(numCamadas - 2);
    for i = 1:numCamadas - 2
        thetaHidden{i} = inicializaPesosAleatorios(tamCamada(i + 1), tamCamada(i + 2));
    end
    % Parametros iniciais para a rede neural.
    paramIniciais = thetaEntrada(:);
    for i = 1:numCamadas - 2
        paramIniciais = [paramIniciais; thetaHidden{i}(:)];
    end
    % Utilizo 50 iteracoes de treino.sum()
    opcoes = optimset('MaxIter', 1000, 'Display', 'iter-detailed');
    lambda = 0.1;
    funcaoCusto = @(p) rnaCusto(p, conjuntoTreino, rotulosTreino, lambda, tamCamada);
    [rna_params, cost] = fmincg(funcaoCusto, paramIniciais, opcoes);
    
    Theta = cell(1, length(tamCamada) - 1);
    indIni = 1;
    indFim = 0;
    for i = 1:numCamadas - 1
        indFim = (indIni - 1) + (tamCamada(i + 1) * (tamCamada(i) + 1));
        Theta{i} = reshape(rna_params(indIni:indFim), ...
                     tamCamada(i + 1), tamCamada(i) + 1);
        indIni = indFim + 1;
    end
    
    pred = predicao(Theta, conjuntoTeste, tamCamada(end));
    fprintf('\nAcuracia no conjunto de treinamento: %f\n', mean( ...
        double(pred == rotuloTeste)) * 100);
end