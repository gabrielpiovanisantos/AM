% A funcao calculaMetricas calcula todas as metricas estipuladas para o
% projeto final, dado um conjunto de predicoes pred e outro conjunto dos
% rotulos corretos.
function [acu, matrix_conf, fmedidaPos, fmedidaNeg] = calculaMetricas(pred, rotulos)
    %acu = mean(double(pred == rotuloTeste)) * 100;
    
    [tp, fp, tn, fn] = calculaAcertosPN(pred, rotulos);
    acu = (tp + tn) / (tp + tn + fp + fn);
    precpos = tp / (tp + fp);
    precneg = tn / (tn + fn);
    recpos = tp / (tp + fn);
    recneg = tn / (fp + tn);
    
    fmedidaPos = 2 * ((precpos * recpos) / (precpos + recpos));
    if(isnan(fmedidaPos))
        fmedidaPos = .0;
    end
    
    fmedidaNeg = 2 * ((precneg * recneg) / (precneg + recneg));
    if(isnan(fmedidaNeg))
        fmedidaNeg = .0;
    end
    matrix_conf = [tp, fn; fp, tn];
end