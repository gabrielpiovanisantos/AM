function p = predicao(Theta, X, labels)
%PREDICAO Prediz o rotulo de uma amostra apresentada a rede neural
%   p = PREDICAO(Theta1, Theta2, X) prediz o rotulo de X ao utilizar
%   os pesos treinados na rede neural (Theta1, Theta2)

m = size(X, 1);

p = zeros(size(X, 1), 1);
h = X;
for i = 1:length(Theta)
    h = sigmoide([ones(m, 1) h] * Theta{i}');
end
% h1 = sigmoide([ones(m, 1) X] * Theta1');
% h2 = sigmoide([ones(m, 1) h1] * Theta2');
[dummy, p] = max(h, [], 2);
if(labels == 1)
    p = (dummy > .5);
% =========================================================================


end
