% A funcao calculaAcertosPN calcula os acertos positivos, falsos positivos,
% acertos negativos e falso negativos dado uma base de predicao pred e
% outra base de rotulos rotulos.
function [tp, fp, tn, fn] = calculaAcertosPN(pred, rotulos)
    tp = 0;
    fp = 0;
    tn = 0;
    fn = 0;
    for i = 1:length(rotulos)
        if(pred(i) == 1 && rotulos(i) == 1)
            tp = tp + 1;
        elseif(pred(i) == 1 && rotulos(i) == 0)
            fp = fp + 1;
        elseif(pred(i) == 0 && rotulos(i) == 0)
            tn = tn + 1;
        else
            fn = fn + 1;
        end
    end
end