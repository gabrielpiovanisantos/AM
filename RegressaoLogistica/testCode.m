n_obs  = size(year1conjunto, 1);  % number observations
n_vars = size(year1conjunto, 2);     % number of variables
max_degree  = 2;     % order of polynomial

X = year1conjunto;  % generate random, strictly positive data

stacked = zeros(0, n_vars); %this will collect all the coefficients...    
for d = 1:max_degree          % for degree 1 polynomial to degree 'order'
    stacked = [stacked; atributosPolinomiais(n_vars, d)];
end

newX = zeros(size(X,1), size(stacked,1));
for(i = 1:size(stacked,1))
    accumulator = ones(n_obs, 1);
    for(j = 1:n_vars)
        accumulator = accumulator .* X(:,j).^stacked(i,j);
    end
    newX(:,i) = accumulator;
end