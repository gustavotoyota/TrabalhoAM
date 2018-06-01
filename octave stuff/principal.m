%clear all;
%clc;

more off;

%addpath('preprocessamento');
%[X, y] = preprocessamento('aps_failure_training_set.csv');
%[A, b] = preprocessamento_test('aps_failure_test_set.csv');

addpath('metodos');
metodos(eval('X', '[]'), eval('y', '[]'));