%clear all;
%clc;

more off;

addpath('preprocessamento');
addpath('metodos');

%[X, y] = preprocessamento('aps_failure_training_set.csv', 'aps_failure_test_set.csv');
metodos(eval('X', '[]'), eval('y', '[]'), eval('X_teste', '[]'), eval('y_teste', '[]'));