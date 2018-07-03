% Funcao principal para o trabalho O Uso de Aprendizado de Máquina para 
%   Diagnóstico de Falhas em Componentes do Sistema de Pressão de Ar (APS) em Caminhões

% Gustavo Takachi Toyota
% Lucas Rigo Yoshimura
% Matheus da Silva Jesus
% Pedro Reis Pires


% Configura o ambiente
clear all;
clc;
more off;

% Adiciona os caminhos
addpath('preprocessamento');
addpath('metodos');

% Realiza o preprocessamento
%[X, y, X_teste, y_teste] = preprocessamento('aps_failure_training_set.csv', 'aps_failure_test_set.csv');


% Carrega e treina cada base preprocessada para o metodo especifico
% Base PP1
load(strcat('preprocessamento/PP1.mat'), 'X', 'y', 'X_teste', 'y_teste', '-mat');
metodos(eval('X', '[]'), eval('y', '[]'), eval('X_teste', '[]'), eval('y_teste', '[]'), {"rede_neural2"}, {"rede_neural2"});

% Base PP2 - comentada devido a nao ocorrencia de melhor resultado para metodo especifico
% load(strcat('preprocessamento/PP2.mat'), 'X', 'y', 'X_teste', 'y_teste', '-mat');
% metodos(eval('X', '[]'), eval('y', '[]'), eval('X_teste', '[]'), eval('y_teste', '[]'), {}, {});

% Base PP3
load(strcat('preprocessamento/PP3.mat'), 'X', 'y', 'X_teste', 'y_teste', '-mat');
metodos(eval('X', '[]'), eval('y', '[]'), eval('X_teste', '[]'), eval('y_teste', '[]'), {"regressao_logistica", "svm"}, {"regressao_logistica", "svm"});

% Base PP4
load(strcat('preprocessamento/PP4.mat'), 'X', 'y', 'X_teste', 'y_teste', '-mat');
metodos(eval('X', '[]'), eval('y', '[]'), eval('X_teste', '[]'), eval('y_teste', '[]'), {"occ_k_vizinhos", "occ_svm"}, {"occ_k_vizinhos", "occ_svm"});

% Base PP5
load(strcat('preprocessamento/PP5.mat'), 'X', 'y', 'X_teste', 'y_teste', '-mat');
metodos(eval('X', '[]'), eval('y', '[]'), eval('X_teste', '[]'), eval('y_teste', '[]'), {"k_vizinhos", "nw_k_vizinhos"}, {"k_vizinhos", "nw_k_vizinhos"});
