function [X, y] = remover_dados(X, y, threshold_colunas, threshold_linhas)
  fprintf('Removendo dados.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/converter_colunas.mat', 'X', 'y', '-mat');
  end
  
  % Converter threshold de porcentagem para quantidade
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  threshold_linhas_qtd = threshold_linhas * num_colunas / 100;
  threshold_colunas_qtd = threshold_colunas * num_linhas / 100;
  
  % Remover colunas
  fprintf('- Removendo colunas (Threshold de faltantes: %.2f%%).\n', threshold_colunas);
  
  matriz_faltantes = X < 0;
  faltantes_colunas = sum(matriz_faltantes, 1);
  colunas_removidas = find(faltantes_colunas >= threshold_colunas_qtd);
  X(:, colunas_removidas) = [];
  
  % Remover linhas
  fprintf('- Removendo linhas (Threshold de faltantes: %.2f%%).\n', threshold_linhas);
  
  matriz_faltantes = X < 0;
  faltantes_linhas = sum(matriz_faltantes, 2);
  linhas_removidas = find(faltantes_linhas >= threshold_linhas_qtd);
  X(linhas_removidas, :) = [];
  y(linhas_removidas, :) = [];
  
  % Salvar outputs
  save('preprocessamento/remover_dados.mat', 'X', 'y', 'colunas_removidas', '-mat');
end  