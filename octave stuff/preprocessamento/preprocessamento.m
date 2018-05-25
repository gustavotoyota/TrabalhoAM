function [X, y] = preprocessamento(arquivo_csv)
  %colunas_texto = carregar_colunas(arquivo_csv);
  %[X, y] = converter_colunas(eval('colunas_texto', '[]'));
  [X, y] = remover_dados(eval('X', '[]'), eval('y', '[]'), 10, 20);
  X = preencher_faltantes(eval('X', '[]'));
  X = normalizar_dados(eval('X', '[]'));
end