clear; close all; clc;

%year1 = readData('1year.arff');
%year2 = readData('2year.arff');
%year3 = readData('3year.arff');
%year4 = readData('4year.arff');
%year5 = readData('5year.arff');

load('year1.mat');
load('year2.mat');
load('year3.mat');
load('year4.mat');
load('year5.mat');
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
[year1conjunto, year1AposNorm] = preprocessaDados(year1);
disp('Processando conjunto ano 2.');
[year2conjunto, year2AposNorm] = preprocessaDados(year2);
disp('Processando conjunto ano 3.');
[year3conjunto, year3AposNorm] = preprocessaDados(year3);
disp('Processando conjunto ano 4.');
[year4conjunto, year4AposNorm] = preprocessaDados(year4);
disp('Processando conjunto ano 5.');
[year5conjunto, year5AposNorm] = preprocessaDados(year5);

