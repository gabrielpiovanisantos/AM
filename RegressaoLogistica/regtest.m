X = year1conjunto;
y = year1rotulos;
% Inicializa os parametros que serao ajustados
theta_inicial = zeros(size(X, 2) + 1, 1);
[m, n] = size(X);
X = [ones(m, 1) X];

% Configura parametro de regularizacao lambda igual a 1
lambda = 1;

% Calcula e exibe custo inicial e gradiente para regressao logistica com
% regularizacao

%  VOCE PRECISA COMPLETAR O CODIGO FUNCAOCUSTOREG.M
[custo, grad] = funcaoCustoReg(theta_inicial, X, y, lambda);

fprintf('\n\nCusto para theta inicial (zeros): %f\n', custo);

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% ============= Parte 8: Regularizacao e desempenho =============
%  Nesta etapa, voce pode testar diferente valores de lambda e verificar
%  como a regularizacao afeta o limite de decisao
%

% Inicializa os parametros que serao ajustados
theta_inicial = zeros(size(X, 2), 1);

% Configura o parametro regularizacao lambda igual a 1
lambda = 1;

% Configura opticoes
opcoes = optimset('GradObj', 'on', 'MaxIter', 100);

% Otimiza o gradiente
[theta, J, exit_flag] = ...
		fminunc(@(t)(funcaoCustoReg(t, X, y, lambda)), theta_inicial, opcoes);
p = predicao(theta, X);

fprintf('Acuracia na base de treinamento: %f\n', mean(double(p == y)) * 100);

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;