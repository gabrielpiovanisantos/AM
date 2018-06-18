n_obs  = size(year1conjunto, 1); 
n_vars = size(year1conjunto, 2);     
max_degree  = 2;     

X = year1conjunto; 

stacked = zeros(0, n_vars);
for d = 1:max_degree          
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
