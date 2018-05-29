function [X, y] = remover_dados(X, y, threshold_colunas, threshold_linhas)
  fprintf('Removendo dados.\n');
  
  % Carregar inputs
  if isempty(X)
    load('preprocessamento/remover_outliers.mat', 'X', '-mat');
  end
  if isempty(y)
    load('preprocessamento/converter_colunas.mat', 'y', '-mat');
  end
  load('preprocessamento/remover_outliers.mat', 'limites_inferiores', 'limites_superiores', '-mat');
  
  % Converter threshold de porcentagem para quantidade
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  threshold_linhas_qtd = threshold_linhas * num_colunas / 100;
  threshold_colunas_qtd = threshold_colunas * num_linhas / 100;
  
  % Remover colunas
  fprintf('- Removendo colunas (Threshold de faltantes: %.2f%%).\n', threshold_colunas);
  
  % Obter colunas por faltante
  matriz_faltantes = X < 0;
  faltantes_colunas = sum(matriz_faltantes, 1);
  colunas_removidas = find(faltantes_colunas >= threshold_colunas_qtd);
  
  % Obter colunas de valores iguais
  for indice_coluna = 1:num_colunas
    coluna = X(:,indice_coluna);    
    coluna = coluna(coluna >= 0);
    if all(coluna(1) == coluna)
      colunas_removidas = [colunas_removidas indice_coluna];
    end
  end
  
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
  save('preprocessamento/remover_dados.mat', 'X', 'y', 'colunas_removidas', 'limites_inferiores', 'limites_superiores', '-mat');
end  
