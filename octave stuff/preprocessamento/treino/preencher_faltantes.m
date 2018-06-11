% Preenche os faltantes com a mediana do atributo

% ENTRADA
%   X = [MxN] base de dados

% SAIDA
%          X = [MxN] base de dados sem atributos faltantes
%   medianas = [1xN] medianas para preenchimento

function [X, medianas] = preencher_faltantes(X)
  fprintf('Preenchendo faltantes com a mediana.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/treino/outputs/balancear_classes.mat', 'X', '-mat');
  endif
  
  % Iniciar variaveis  
  num_colunas = size(X, 2);
  medianas = zeros(1, num_colunas);
  
  for indice_coluna = 1:num_colunas
    coluna = X(:, indice_coluna);
    
    % Calcular mediana
    medianas(indice_coluna) = calcular_percentil(coluna(coluna >= 0), 50);
    
    % Preencher faltantes com a mediana
    indices_faltantes = find(coluna < 0);
    X(indices_faltantes, indice_coluna) = medianas(indice_coluna);
  endfor
  
  % Salvar outputs
  save('preprocessamento/treino/outputs/preencher_faltantes.mat', 'X', 'medianas', '-mat');
endfunction