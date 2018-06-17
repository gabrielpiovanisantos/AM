% A funcao divideMatriz divide a matriz 'm' por linhas baseada nas 
% porcentagens em 'p', ou seja, se p = [10 10 80], divideMatriz ira dividir 
% a matriz 'm' da forma que a matriz do primeiro indice de divMat tera 10%
% de m, do segundo indice tera 10% e do terceiro indice tera 80%. 
function divMat = divideMatriz(m, p)
    % As porcentagens em p tem que ser igual a 100%.
    assert(sum(p) <= 1);
    divMat = cell(length(p));
    tam = size(m, 1);
    % Para cada porcentagem em p tenho que cortar m.
    for i = 1:length(p)
        div = int32(floor(p(1, i) * tam));
        divMat{i} = m(1:div, :);
        m(1:div, :) = [];
    end
    
    % Se sobrou alguma amostra em 'm' concateno no ultimo indice de divMat.
    if(length(m) > 0)
        divMat{length(p)} = [divMat{length(p)}; m];
    end
end