%clear; close all; clc;
% Se carregaArq for 1 entao ele carrega os arquivos ja processados
% previamente, senao ele le os arquivos do 0, a partir dos arquivos .arff
% para realmente refazer todos os passos do 0.
carregaArq = 1;

% Variaveis que dizem quais testes serao rodados. Utilizado caso
% queira testar apenas um tipo de classificador ao rodar os testes. Se tudo
% for 1, ira testar todos os algoritmos.
rKnn = 0;
rRna = 0;
rSVM = 1;
rRegLog = 1;

% Variaveis que dizem quais preprocessamentos serao aplicados no conjunto
% de dados.
% aNorm = 1; % Flag para normalizar os dados
% aKnn = 1; % Flag para o KNN de imputacao
% aReg = 1; % Flag para a reg. linear de imputacao
% 
% if(carregaArq == 0)
%     year1 = readData('1year.arff');
%     year2 = readData('2year.arff');
%     year3 = readData('3year.arff');
%     year4 = readData('4year.arff');
%     year5 = readData('5year.arff');
% else
%     load('year1.mat');
%     load('year2.mat');
%     load('year3.mat');
%     load('year4.mat');
%     load('year5.mat');
% end
% 
% year1rotulos = year1(:, 65);
% year1(:, 65) = [];
% year2rotulos = year2(:, 65);
% year2(:, 65) = [];
% year3rotulos = year3(:, 65);
% year3(:, 65) = [];
% year4rotulos = year4(:, 65);
% year4(:, 65) = [];
% year5rotulos = year5(:, 65);
% year5(:, 65) = [];
%  
% disp('Processando conjunto ano 1.');
% [year1conjunto, year1AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
% disp('Processando conjunto ano 2.');
% [year2conjunto, year2AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
% disp('Processando conjunto ano 3.');
% [year3conjunto, year3AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
% disp('Processando conjunto ano 4.');
% [year4conjunto, year4AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);
% disp('Processando conjunto ano 5.');
% [year5conjunto, year5AposNorm] = preprocessaDados(year1, aNorm, aKnn, aReg);

realizaTestes(year1conjunto, year1rotulos, rKnn, rRna, rSVM, rRegLog);
realizaTestes(year2conjunto, year2rotulos, rKnn, rRna, rSVM, rRegLog);
realizaTestes(year3conjunto, year3rotulos, rKnn, rRna, rSVM, rRegLog);
realizaTestes(year4conjunto, year4rotulos, rKnn, rRna, rSVM, rRegLog);
realizaTestes(year5conjunto, year5rotulos, rKnn, rRna, rSVM, rRegLog);
