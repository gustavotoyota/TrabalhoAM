% Normaliza dados de teste com as medias e desvios padroes do treinamento

% ENTRADA
%                 X = [MxN] base de dados de teste
%            medias = [MxN] medias para normalizacao
%   desvios_padroes = [MxN] desvios padroes para normalizacao

% SAIDA
%   X = [MxN] base de dados normalizada

function X = normalizar_dados_teste(X, medias, desvios_padroes)
  fprintf('Normalizando dados da base de testes.\n');
  
  % Carregar inputs
  if isempty(X) || isempty(medias) || isempty(desvios_padroes)
    load('preprocessamento/teste/outputs/preencher_faltantes.mat', 'X', '-mat');
    load('preprocessamento/treino/outputs/normalizar_dados.mat', 'medias', 'desvios_padroes', '-mat');
  endif
  
  % Normalizar dados
  X = (X - medias) ./ desvios_padroes;
  
  % Salvar outputs
  save('preprocessamento/teste/outputs/normalizar_dados.mat', 'X', '-mat');
endfunction