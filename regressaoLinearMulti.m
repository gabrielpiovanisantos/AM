%function [theta] = regressaoLinearMulti(X, y, alpha, iteracoes)
    clear; close all; clc;
    load('year1.mat');
    X = year1;
    clear year1;
    X(:, 65) = [];
    X(isnan(X)) = 0;
    y = X(:, 2);
    X(:, 2) = [];
    [X_norm, ~, ~] = normalizar(X);
    [y_norm, ~, ~] = normalizar(y);
    
    X_norm = [ones(7027, 1), X_norm];
    theta = zeros(1, size(X_norm, 2));
    J = computarCustoMulti(X_norm, y_norm, theta);
    
    iteracoes = 100000;
    alpha = 0.01;
    [theta, J_historico] = gradienteDescenteMulti(X_norm, y_norm, theta, alpha, iteracoes);
%end