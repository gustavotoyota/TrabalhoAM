function [X, y] = remover_dados_test(X, y, threshold_colunas, threshold_linhas)
  fprintf('Removendo dados.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/remover_outliers_test.mat', 'X', '-mat');
  end
  if isempty(y)
    load('preprocessamento/converter_colunas_test.mat', 'y', '-mat');
  end
  load('preprocessamento/remover_outliers_test.mat', 'limites_inferiores', 'limites_superiores', '-mat');
  load('preprocessamento/remover_dados.mat', 'colunas_removidas', '-mat');
  
  % Converter threshold de porcentagem para quantidade
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  threshold_linhas_qtd = threshold_linhas * num_colunas / 100;
  threshold_colunas_qtd = threshold_colunas * num_linhas / 100;
  
  % Remover colunas
  fprintf('- Removendo colunas (Threshold de faltantes: %.2f%%).\n', threshold_colunas);
  
  % Remover colunas e limites de outliers
  X(:, colunas_removidas) = [];    
  limites_inferiores(:, colunas_removidas) = [];
  limites_superiores(:, colunas_removidas) = [];
  
  % Remover linhas
  fprintf('- Removendo linhas (Threshold de faltantes: %.2f%%).\n', threshold_linhas);
  
  matriz_faltantes = X < 0;
  faltantes_linhas = sum(matriz_faltantes, 2);
  linhas_removidas = find(faltantes_linhas >= threshold_linhas_qtd);
  X(linhas_removidas, :) = [];
  y(linhas_removidas, :) = [];
  
  % Salvar outputs
  save('preprocessamento/remover_dados_test.mat', 'X', 'y', 'colunas_removidas', 'limites_inferiores', 'limites_superiores', '-mat');
end
