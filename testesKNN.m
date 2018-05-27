clear; clc;

load('1year.mat');

rotulos = oneYear(:, 65);
oneYear(:, 65) = [];
testes = [3 5 7 9 11 13 15 17 19 21 23 25]; 
classes = 0;
indices = 0;
knns = cell(length(testes));
count = 1;

for i = 1:length(testes)
    classes = zeros(length(oneYear), 1);
    indices = zeros(length(oneYear), testes(i));
    tic;
    for j = 1:length(oneYear)
        [classe, indice] = knn(oneYear(j, :), oneYear, rotulos, testes(i));
        classes(j, 1) = classe;
        indices(j, :) = indice;
    end
    toc;
    fprintf('Termino do calculo com K = %d.\n', i);
    knns{count} = [classes indices];
    count = count + 1;
end