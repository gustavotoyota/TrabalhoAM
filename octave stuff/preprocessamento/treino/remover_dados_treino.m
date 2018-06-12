% Remove dados que tenham muitos atributos faltantes ou todos atributos sejam iguais

% ENTRADA
%                   X = [MxN] base de dados
%                   y = [Mx1] rotulos das amostras
%   threshold_colunas = [1x1] porcentagem de faltantes para remocao de colunas
%    threshold_linhas = [1x1] porcentagem de faltantes para remocao de linhas

% SAIDA
%                   X = [AxB] base de dados com colunas e linhas removidas
%                   y = [Ax1] rotulos das amostras com linhas removidas
%   colunas_removidas = [1xN-B] indices das colunas removidas

function [X, y, colunas_removidas] = remover_dados_treino(X, y, threshold_colunas, threshold_linhas)
  fprintf('Removendo dados.\n');
  
  % Carregar inputs
  if isempty(X) || isempty(y)
    load('preprocessamento/treino/outputs/remover_outliers.mat', 'X', '-mat');
    load('preprocessamento/treino/outputs/converter_colunas.mat', 'y', '-mat');
  endif
  
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
    endif
  endfor
  
  % Remover colunas
  X(:, colunas_removidas) = [];      
  
  % Remover linhas
  fprintf('- Removendo linhas (Threshold de faltantes: %.2f%%).\n', threshold_linhas);
  
  matriz_faltantes = X < 0;
  faltantes_linhas = sum(matriz_faltantes, 2);
  linhas_removidas = find(faltantes_linhas >= threshold_linhas_qtd);
  X(linhas_removidas, :) = [];
  y(linhas_removidas, :) = [];
  
  % Salvar outputs
  save('preprocessamento/treino/outputs/remover_dados.mat', 'X', 'y', 'colunas_removidas', '-mat');
endfunction