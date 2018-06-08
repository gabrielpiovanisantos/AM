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
conjuntoDados = [year1; year2; year3; year4; year5];
clear year1 year2 year3 year4 year5;
rotulos = conjuntoDados(:, 65);
conjuntoDados(:, 65) = [];

[conjuntoDados, conjuntoAposNorm] = preprocessaDados(conjuntoDados);
%[custoLogistico, gradienteLogistico] = custoRegLog(theta,conjunto,conjuntoDados, rotulos);
