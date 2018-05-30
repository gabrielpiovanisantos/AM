function J = computarCustoMulti(X, y, theta)
    m = length(y);
    h = 0;
    for i = 1:size(X, 2)
        h = h + theta(i) * X(:,i);
    end
    J = 1/(2*m) * sum((h - y(:)).^2);
end