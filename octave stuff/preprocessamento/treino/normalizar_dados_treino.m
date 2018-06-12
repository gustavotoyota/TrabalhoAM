% Normaliza dados com media 1 e desvio padrao 0

% ENTRADA
%   X = [MxN] base de dados

% SAIDA
%                 X = [MxN] base de dados normalizada
%            medias = [MxN] medias para normalizacao
%   desvios_padroes = [MxN] desvios_padroes para normalizacao

function [X, medias, desvios_padroes] = normalizar_dados_treino(X)
  fprintf('Normalizando dados.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/treino/outputs/preencher_faltantes.mat', 'X', '-mat');
  endif
  
  % Normalizar dados
  num_linhas = size(X, 1);  
  medias = sum(X ./ num_linhas, 1);
  desvios_padroes = sqrt(sum(((X - medias) .^ 2) ./ num_linhas));
  X = (X - medias) ./ desvios_padroes;
  
  % Salvar outputs
  save('preprocessamento/treino/outputs/normalizar_dados.mat', 'X', 'medias', 'desvios_padroes', '-mat');
endfunction