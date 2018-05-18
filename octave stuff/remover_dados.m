function [X, y, colunas_removidas] = remover_dados(X, y, faltantes_linhas, faltantes_colunas)
  # Carregar inputs
  if isempty(X)
    load("-binary", "converter_colunas.mat", "X", "y");
  end
  if isempty(faltantes_linhas)
    load("-binary", "analisar_faltantes.mat", "faltantes_linhas", "faltantes_colunas");
  end
  
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  threshold_linha = 10 * num_colunas / 100;
  threshold_coluna = 20 * num_linhas / 100;
  
  # Remover linhas
  for linha = num_linhas : -1 : 1
    if faltantes_linhas(linha) >= threshold_linha
      X(linha, :) = [];
    end
  end
  
  colunas_removidas = [];
  
  # Remover colunas
  for coluna = num_colunas : -1 : 1
    if faltantes_colunas(coluna) >= threshold_coluna
      X(:, coluna) = [];
      colunas_removidas(end + 1) = coluna;
    end  
  end
  
  # Salvar outputs
  save("-binary", "remover_dados.mat", "X", "y", "colunas_removidas");
end  