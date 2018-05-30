function [theta, J_historico] = gradienteDescenteMulti(X, y, theta, alpha, num_iter)
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
        h_theta = 0;
        theta_n = zeros(1, size(X, 2));
        for i = 1:size(X, 2)
            h_theta = h_theta + theta(i) .* X(:, i);
        end
        for i = 1:size(X, 2)
            theta_n(1, i) = theta(i) - alpha * (1/m) * (sum((h_theta - y(:)) .* X(:, i)));
        end
        theta = theta_n;
        % ============================================================

        % Armazena o custo J obtido em cada iteracao do gradiente    
        J_historico(iter) = computarCustoMulti(X, y, theta);
        if(iter > 1)
            if(J_historico(iter) > J_historico(iter - 1))
                fprintf("Gradiente cresceu, pare. Iteracao %d.\n", iter);
                J_historico(iter:end) = [];
                break;
            end
        end
        %assert(J_historico(iter) > J_historico(iter - 1), 'Gradiente incorreto');
    end
end