function conjunto = processaTeste(in)
    conjunto = zeros(size(in, 1), 2);
    for i = 1:size(in, 1)
        conjunto(i, 1) = sum(isnan(in(i, :)));
        conjunto(i, 2) = abs(conjunto(i, 1) - size(in, 2)); 
    end
end