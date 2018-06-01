function [X, y] = preprocessamento_test(arquivo_csv)
  %colunas_texto = carregar_colunas_test(arquivo_csv);
  %[X, y] = converter_colunas_test(eval('colunas_texto', '[]'));
  X = remover_outliers_test(eval('X', '[]'));
  [X, y] = remover_dados_test(eval('X', '[]'), eval('y', '[]'), 10, 50);
  [X, y] = balancear_classes_test(eval('X','[]'), eval('y','[]'));
  X = preencher_faltantes_test(eval('X', '[]'));
  X = normalizar_dados_test(eval('X', '[]'));
end