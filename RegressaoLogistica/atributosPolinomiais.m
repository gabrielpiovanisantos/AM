function out = atributosPolinomiais(X, grau)
% ATRIBUTOS POLINOMIAIS Gera atributos polinomiais a partir dos atriburos
% originais da base
%
%   ATRIBUTOSPOLINOMIAIS(X1, X2) mapeia os dois atributos de entrada
%   para atributos quadraticos
%
%   Retorna um novo vetor de mais atributos:
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%
%   As entradas X1, X2 devem ser do mesmo tamanho
%

if(X <= 1)
    out = grau;
else
    out = zeros(0, X);    
    for i = grau:-1:0
        out2 = atributosPolinomiais(X - 1, grau - i);
        out = [out; i * ones(size(out2, 1), 1), out2];
    end    
end

end