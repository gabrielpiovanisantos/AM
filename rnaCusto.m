function [J, grad] = rnaCusto(nn_params, X, y, lambda, tamCamada)
%RNACUSTO Implementa a funcao de custo para a rede neural com duas camadas
%voltada para tarefa de classificacao
%   [J grad] = RNACUSTO(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) calcula o custo e gradiente da rede neural. The
%   Os parametros da rede neural sao colocados no vetor nn_params
%   e precisam ser transformados de volta nas matrizes de peso.
%
%   input_layer_size - tamanho da camada de entrada
%   hidden_layer_size - tamanho da camada oculta
%   num_labels - numero de classes possiveis
%   lambda - parametro de regularizacao
%
%   O vetor grad de retorno contem todas as derivadas parciais
%   da rede neural.
%

% Extrai os parametros de nn_params e alimenta as variaveis Theta1 e Theta2.
% Preciso de pelo menos uma camada hidden.
numCamadas = length(tamCamada);
assert(numCamadas >= 3);

% Teremos uma theta para cada ligacao entre as camadas.
Theta = cell(1, numCamadas - 1);
indIni = 1;
indFim = 0;
for i = 1:(numCamadas - 1)
    indFim = (indIni - 1) + (tamCamada(i + 1) * (tamCamada(i) + 1));
    Theta{i} = reshape(nn_params(indIni:indFim), ...
                 tamCamada(i + 1), tamCamada(i) + 1);
    indIni = indFim + 1;
end

% Definindo variaveis uteis
m = size(X, 1);
         
% As variaveis a seguir precisam ser retornadas corretamente
J = 0;

% ====================== INSIRA SEU CODIGO AQUI ======================
% Instrucoes: Voce deve completar o codigo a partir daqui 
%               acompanhando os seguintes passos.
%
% (1): Lembre-se de transformar os rotulos Y em vetores com 10 posicoes,
%      onde tera zero em todas posicoes exceto na posicao do rotulo
%
% (2): Execute a etapa de feedforward e coloque o custo na variavel J.
%      Apos terminar, verifique se sua funcao de custo esta correta,
%      comparando com o custo calculado em ex05.m.
%
% (3): Implemente o algoritmo de backpropagation para calcular 
%      os gradientes e alimentar as variaveis Theta1_grad e Theta2_grad.
%      Ao terminar essa etapa, voce pode verificar se sua implementacao 
%      esta correta atraves usando a funcao verificaGradiente.
%
% (4): Implemente a regularização na função de custo e gradiente.
%



% -------------------------------------------------------------

% Declaro os deltas para o calculo do gradientes.
D = cell(1, numCamadas - 1);
% D2 = 0;
% D1 = 0;

for i = 1:m
    % Vetor Y com 1 na classe correspondente da amostra X(i).
    Y = zeros(tamCamada(end), 1);
    if(tamCamada(end) > 2)
        Y(y(i) + 1) = 1;
    else
        if(y(i) == 1)
            Y = 1;
        else
            Y = 0;
        end
    end
    % Calculo o a da camada de entrada, ou seja, apenas populo pegando os
    % atributos da amostra i;
    % Para cada camada, a um 'a' e 'z'.
    a = cell(1, numCamadas);
    z = cell(1, numCamadas);
    % A primeira camada tem os valores de entrada.
    a{1} = [1; X(i, :)'];
    for j = 2:numCamadas - 1
        z{j} = Theta{j - 1} * a{j - 1};
        a{j} = [1; sigmoide(z{j})];
    end
    z{numCamadas} = Theta{numCamadas - 1} * a{numCamadas - 1};
    a{numCamadas} = sigmoide(z{numCamadas});
    %a1 = [1; X(i, :)'];
    % Calculo o z da camada hidden e depois calculo a abertura da camada
    % hidden.
    %z2 = Theta1 * a1;
    %a2 = [1; sigmoide(z2)];
    % Calculo o z da camada de saida e depois calculo a abertura da camada
    % de saida, que sera a minha hipotese.
    %z3 = Theta2 * a2;
    %a3 = sigmoide(z3);
    % Calculo o custo para esse elemento com forme a formula fornecida no
    % PDF e acumulo o custo em J.
    for j = 1:tamCamada(end)
        J = J + (-Y(j) * log(a{numCamadas}(j)) - (1 - Y(j)) * log(1 - a{numCamadas}(j)));
    end
    deltinha = cell(1, numCamadas);
    
    deltinha{numCamadas} = a{numCamadas} - Y;
    for j = numCamadas - 1:-1:2
        theta = Theta{j};
        theta(:, 1) = [];
        deltinha{j} = theta' * deltinha{j + 1} .* gradienteSigmoide(z{j});
    end
    
    for j = numCamadas - 1:-1:1
        t = deltinha{j + 1} * a{j}';
        if(isempty(D{j}))
            D{j} = t;
        else
            D{j} = D{j} + t;
        end
    end
    
    % Removo o bias para o calculo do erro deste elemento.
%     theta2semBias = Theta2;
%     theta2semBias(:, 1) = [];
%     % Calculo os erros das camadas baseado na formula do PDF.
%     % Calculo o erro da camada de saida.
%     deltinha3 = a3 - Y;
%     % Calculo o erro da camada intermediaria. 
%     deltinha2 = theta2semBias' * deltinha3 .* gradienteSigmoide(z2);
    % Acumulo os erros em delta 1 e 2.
%     D2 = D2 + deltinha3 * a2';
%     D1 = D1 + deltinha2 * a1';
end

Theta_grad_reg = cell(1, numCamadas - 1);
for i = 1:numCamadas - 1
    Theta_grad_reg{i} = ((lambda / m) .* Theta{i});
    Theta_grad_reg{i}(:, 1) = 0;
end

Theta_grad = cell(1, numCamadas - 1);
for i = 1:numCamadas - 1
    Theta_grad{i} = ((1 / m) .* D{i}) + Theta_grad_reg{i};
end

% Calculo a regularizacao do theta 1 e 2.
% Theta1_grad_reg = ((lambda / m) .* Theta1);
% Theta2_grad_reg = ((lambda / m) .* Theta2);
% Zero a primeira coluna pois nela contem o bias, que nao utilizo na
% regularizacao, logo essa coluna nao ira contribuir para o resultado ja
% que tudo eh zero.
% Theta1_grad_reg(:, 1) = 0;
% Theta2_grad_reg(:, 1) = 0;
% Calculo os novos valores de Theta1 e 2 baseado na formula do PDF, com
% regularizacao.
% Theta1_grad = ((1 / m) .* D1) + Theta1_grad_reg;
% Theta2_grad = ((1 / m) .* D2) + Theta2_grad_reg;

for i = 1:numCamadas - 1
    Theta{i}(:, 1) = [];
end

Theta_reg = cell(1, numCamadas - 1);
for i = 1:numCamadas - 1
    Theta_reg{i} = sum(sum(Theta{i} .^ 2));
end

regTotal = 0;
for i = 1:numCamadas - 1
    regTotal = regTotal + Theta_reg{i};
end

J_reg = (lambda / (2 * m)) * regTotal;
J = (1 / m) * J + J_reg;
% Removo a primeira coluna de theta para excluir o bias, que nao eh incluso
% no calculo do custo.
% Theta1(:, 1) = [];
% Theta2(:, 1) = [];
% % Calculo a regularizacao.
% theta1_reg = sum(sum(Theta1 .^ 2));
% theta2_reg = sum(sum(Theta2 .^ 2));
% J_reg = (lambda / (2 * m)) * (theta1_reg + theta2_reg);
% % Finalizo o calculo do custo com regularizacao.
% J = (1 / m) * J + J_reg;

% =========================================================================

% Junta os gradientes
grad = Theta_grad{1}(:);
for i = 2:numCamadas - 1
    grad = [grad; Theta_grad{i}(:)];
end
% grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
