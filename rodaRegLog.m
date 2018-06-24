% Funcao roda o knn com K ate o K fornecido, ou seja, se for fornecido k =
% 11, os testes feitos serao com k = 1,3,5,7,9,11. O retorno sera um cell
% contendo o resultado do KNN, ou seja, dado o exemplo, teriamos no indice
% 1 do cell array os resultados do k = 1, e assim por diante.
function reglogTeste = rodaRegLog(conjuntoTreino, rotulosTreino, conjuntoTeste, lambda)
%    addpath('./RegLog/');
 
    tic;
    
    [m, n] = size(conjuntoTreino);
    theta_inicial = zeros(n+1, 1);            
    
    X = [ones(m,1) conjuntoTreino];
    
    [custo, grad] = custoRegLog(theta_inicial, X, rotulosTreino, lambda);
 
    opcoes = optimset('MaxIter', 2000, 'Display', 'iter-detailed');
    [theta, custo] = fminunc(@(t)(funcaoCusto(t, X, rotulosTreino)), theta_inicial, opcoes);
    
    reglogTeste = predicao({theta'}, conjuntoTeste, 1);

    toc;
end