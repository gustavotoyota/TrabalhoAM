clear all;
clc;

more off;

addpath('preprocessamento');
addpath('metodos');

% MUDAR AQUI
%nome = "Gustavo"
%nome = "Lucas"
%nome = "Matheus"
nome = "Pedro"

%[X, y, X_teste, y_teste] = preprocessamento('aps_failure_training_set.csv', 'aps_failure_test_set.csv');

% Roda pra base 1
load(strcat('preprocessamento/', nome, '1.mat'), 'X', 'y', 'X_teste', 'y_teste', '-mat');
metodos(eval('X', '[]'), eval('y', '[]'), eval('X_teste', '[]'), eval('y_teste', '[]'), '1');

% Roda pra base 2
%load(strcat('preprocessamento/', nome, '2.mat'), 'X', 'y', 'X_teste', 'y_teste', '-mat');
%metodos(eval('X', '[]'), eval('y', '[]'), eval('X_teste', '[]'), eval('y_teste', '[]'), '2';