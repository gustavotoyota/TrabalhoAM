% Preenche os faltantes com a mediana

% ENTRADA
%          X = [MxN] base de dados de teste
%   medianas = [1xN] medianas para preenchimento

% SAIDA
%   X = [MxN] base de dados de teste sem atributos faltantes

function X = preencher_faltantes_teste(X, medianas)
  fprintf('Preenchendo faltantes da base de testes.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/teste/outputs/remover_dados.mat', 'X', '-mat');
  endif
  if isempty(medianas)
    load('preprocessamento/treino/outputs/preencher_faltantes.mat', 'medianas');
  endif
  
  % Preencher faltantes com a mediana
  num_colunas = size(X, 2);
  for indice_coluna = 1:num_colunas
    coluna = X(:, indice_coluna);
    indices_faltantes = find(coluna < 0);
    X(indices_faltantes, indice_coluna) = medianas(indice_coluna);
  endfor
  
  % Salvar outputs
  save('preprocessamento/teste/outputs/preencher_faltantes.mat', 'X', '-mat');
endfunction