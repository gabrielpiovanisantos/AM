function [theta, J_historico] = gradienteDescente(X, y, theta, alpha, num_iter)
%GRADIENTEDESCENTE Executa o gradiente descente para aprender e otimizar theta
%   theta = GRADIENTEDESENTE(X, y, theta, alpha, num_iter) atualiza theta usando 
%   num_iter passos do gradiente com taxa de aprendizado alpha

% Initializa algumas variaveis uteis
m = length(y); % numero de exemplos de treinamento
J_historico = zeros(num_iter, 1);

for iter = 1:num_iter

    % ====================== ESCREVA O SEU CODIGO AQUI ====================
    % Instrucoes: Execute um unico passo do gradiente para ajustar o vetor
    %             theta. 
    %
    % Dica: para verificar se a o gradiente esta correto, verifique se a 
    %       funcao de custo (computarCusto) nunca aumenta de valor no 
    %       decorrer das iteracoes. Para facilitar, em ex02.m ha uma funcao
    %       que plota o custo J no decorrer das iteracoes. A linha nunca
    %       pode ser crescente. Se for, reduza alpha.
    %
 
    % Calculo a hipotese baseado na formula do slide.
    h_theta = theta(1) + theta(2).*X(:, 2);
    % Calculo o J(0, 1) utilizando a formula fornecida no slide.
    J_theta = [sum(h_theta - y(:)) sum((h_theta - y(:)).*X(:, 2))];
    % Finalizo o calculo do gradiente e atualizo os thetas.
    theta = [(theta(1) - alpha*(1/m)*(J_theta(1))) (theta(2) - alpha*(1/m)*(J_theta(2)))];
    % Aplico a transposta de theta para trocar linhas e colunas.
    theta = transpose(theta);
    
    % ============================================================

    % Armazena o custo J obtido em cada iteracao do gradiente    
    J_historico(iter) = computarCusto(X, y, theta);
    % assert(J_historico(iter) > J_historico(iter - 1), 'Gradiente incorreto');
end

end
