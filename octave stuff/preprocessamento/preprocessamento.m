function [X, y] = preprocessamento(arquivo_csv)
  %colunas_texto = carregar_colunas(arquivo_csv);
  %[X, y] = converter_colunas(eval('colunas_texto', '[]'));
  X = remover_outliers(eval('X', '[]'));
  [X, y] = remover_dados(eval('X', '[]'), eval('y', '[]'), 10, 50);
  %[X, y] = balancear_classes(eval('X','[]'), eval('y','[]'));
  X = preencher_faltantes(eval('X', '[]'));
  X = normalizar_dados(eval('X', '[]'));
end
