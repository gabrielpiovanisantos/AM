function [J, grad] = custoRegLog(theta, X, y, lambda)
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
%chama a funcao sigmoid para o calculo da hipotese h
h = sigmoide(X*theta);
%calculo do custo 
J = (sum(-(y).*log(h)-(1-y).*log(1-h))/m);
%calculo do gradiente para cada dimensao
rem = transpose(theta);
% Assim j = 0 nao sera regularizado na formula, pois a primeira variavel
% eh 0.
rem(1) = 0;
grad = (sum((h - y).*X))/m + (lambda / m) * rem;
