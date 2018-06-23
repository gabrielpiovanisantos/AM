% A funcao conta linhas iguais retorna o numero de linhas que sao iguais
% a n entre duas matrizes a e b.
function count = contaLinhasIguais(a, b, n)
    count = 0;
    for i = 1:length(a)
        if(a(i) == n && b(i) == n)
            count = count + 1;
        end
    end
end