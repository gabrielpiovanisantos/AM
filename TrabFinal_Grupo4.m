clear; close all; clc;
% Se carregaArq for 1 entao ele carrega os arquivos ja processados
% previamente, senao ele le os arquivos do 0, a partir dos arquivos .arff
% para realmente refazer todos os passos do 0, se carregaArq for 2, ele
% carrega os dados preprocessados e nao realiza nenhum preprocessamento.
carregaArq = 2;

% Salvo o output da janela de comandos em output.txt
diary('output.txt');

% Variaveis que dizem quais testes serao rodados. Utilizado caso
% queira testar apenas um tipo de classificador ao rodar os testes. Se tudo
% for 1, ira testar todos os algoritmos.
rKnn = 1;
rRna = 1;
rSVM = 1;
rRegLog = 1;

% Variaveis que dizem quais preprocessamentos serao aplicados no conjunto
% de dados.
aNorm = 1; % Flag para normalizar os dados
aKnn = 1; % Flag para o KNN de imputacao
aReg = 1; % Flag para a reg. linear de imputacao

if(carregaArq == 0)
    year1 = readData('1year.arff');
    year2 = readData('2year.arff');
    year3 = readData('3year.arff');
    year4 = readData('4year.arff');
    year5 = readData('5year.arff');
elseif(carregaArq == 1)
    load('year1.mat');
    load('year2.mat');
    load('year3.mat');
    load('year4.mat');
    load('year5.mat');
else
    load('year1completo.mat');
    load('year2completo.mat');
    load('year3completo.mat');
    load('year4completo.mat');
    load('year5completo.mat');
end

if(carregaArq < 2)
    year1rotulos = year1(:, 65);
    year1(:, 65) = [];
    year2rotulos = year2(:, 65);
    year2(:, 65) = [];
    year3rotulos = year3(:, 65);
    year3(:, 65) = [];
    year4rotulos = year4(:, 65);
    year4(:, 65) = [];
    year5rotulos = year5(:, 65);
    year5(:, 65) = [];

    disp('Processando conjunto ano 1.');
    [year1conjunto, year1AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
    disp('Processando conjunto ano 2.');
    [year2conjunto, year2AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
    disp('Processando conjunto ano 3.');
    [year3conjunto, year3AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
    disp('Processando conjunto ano 4.');
    [year4conjunto, year4AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
    disp('Processando conjunto ano 5.');
    [year5conjunto, year5AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
end

disp('Realizando testes no conjunto do ano 1.')
realizaTestes(year1conjunto, year1rotulos, rKnn, rRna, rSVM, rRegLog);
disp('Realizando testes no conjunto do ano 2.')
realizaTestes(year2conjunto, year2rotulos, rKnn, rRna, rSVM, rRegLog);
disp('Realizando testes no conjunto do ano 3.')
realizaTestes(year3conjunto, year3rotulos, rKnn, rRna, rSVM, rRegLog);
disp('Realizando testes no conjunto do ano 4.')
realizaTestes(year4conjunto, year4rotulos, rKnn, rRna, rSVM, rRegLog);
disp('Realizando testes no conjunto do ano 5.')
realizaTestes(year5conjunto, year5rotulos, rKnn, rRna, rSVM, rRegLog);

diary off;