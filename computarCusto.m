function J = computarCusto(X, y, theta)
%COMPUTARCUSTO Calcula o custo da regressao linear
%   J = COMPUTARCUSTO(X, y, theta) calcula o custo de usar theta como 
%   parametro da regressao linear para ajustar os dados de X e y

% Initializa algumas variaveis uteis
m = length(y); % numero de exemplos de treinamento

% Voce precisa retornar a seguinte variavel corretamente
J = 0;

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Calcule o custo de uma escolha particular de theta.
%             Voce precisa armazenar o valor do custo em J.

% Utilizo a formula fornecida no slide para calcular o custo J.
% Calculo a hipotese.
h = theta(1) + theta(2)*X(:,2);
% Calculo o somatorio baseado na formula.
soma = sum((h - y(:)).^2);
% Finalizo o calculo do custo.
J = 1/(2*m) * soma;

% =========================================================================

end
