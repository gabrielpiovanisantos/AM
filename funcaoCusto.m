function [J, grad] = funcaoCusto(theta, X, y)
%FUNCAOCUSTO Calcula o custo da regressao logistica
%   J = FUNCAOCUSTO(X, y, theta) calcula o custo de usar theta como 
%   parametro da regressao logistica para ajustar os dados de X e y

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

% Calculo o gradiente e o custo baseado no PDF.
grad = sum((sigmoide(X * theta) - y).*X) / m;
J = (1/m) * sum(-transpose(y) * log(sigmoide(X * theta)) - (1 - transpose(y)) * log(1 - sigmoide(X * theta)));

% =============================================================

end
