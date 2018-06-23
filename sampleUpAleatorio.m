% A funcao sampleUpAleatorio gera um novo conjunto contendo n amostras
% baseadas dos maximos e minimos extraidor de conjunto, novoConj contera
% apenas as amostras geradas.
function novoConj = sampleUpAleatorio(conjunto, n)
    maximo = max(conjunto);
    minimo = min(conjunto);
    novoConj = zeros(n, size(conjunto, 2));
    for i = 1:n
        for j = 1:size(conjunto, 2)
            novoConj(i, j) = (maximo(j) - minimo(j)) .* rand(1) + minimo(j);
        end
    end
end