function [J, grad] = funcaoCustoReg(theta, X, y, lambda)
%FUNCAOCUSTOREG Calcula o custo da regressao logistica com regularizacao
%   J = FUNCAOCUSTOREG(theta, X, y, lambda) calcula o custo de usar theta 
%   como parametros da regressao logistica para ajustar os dados de X e y 

% Initializa algumas variaveis uteis
m = length(y); % numero de exemplos de treinamento

% Voce precisa retornar as seguintes variaveis corretamente
J = 0;
grad = zeros(size(theta));

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Calcule o custo de uma escolha particular de theta.
%             Voce precisa armazenar o valor do custo em J.
%             Calcule as derivadas parciais e encontre o valor do gradiente
%             para o custo com relacao ao parametro theta
%
% Obs: grad deve ter a mesma dimensao de theta
%
% Calculo o custo e o gradiente porem com a regularizacao.
J = (1 / m) * sum(-transpose(y) * log(sigmoid(X * theta)) - (1 - transpose(y)) * log(1 - sigmoid(X * theta))) + lambda/(2*m) * sum(theta(2:end).^2);
% Nao aplico a regularizacao para j = 0.
rem = transpose(theta);
% Assim j = 0 nao sera regularizado na formula, pois a primeira variavel
% eh 0.
rem(1) = 0;
grad = ((1 / m) * (sum((sigmoid(X*theta) - y).*X))) + (lambda / m) * rem;

% =============================================================

end
