function [faltantes_linhas, faltantes_colunas] = analisar_faltantes(X)
  if isempty(X)
    load("-binary", "converter_colunas.mat", "X");
  end
  
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  faltantes_linhas = zeros(num_linhas, 1);
  faltantes_colunas = zeros(num_colunas, 1);
  
  for linha = 1 : num_linhas
    for coluna = 1 : num_colunas
      if X(linha, coluna) < 0
        faltantes_linhas(linha) = faltantes_linhas(linha) + 1;
        faltantes_colunas(coluna) = faltantes_colunas(coluna) + 1;
      end
    end  
  end  
  
  save("-binary", "analise_faltantes.mat", "faltantes_linhas", "faltantes_colunas");
end