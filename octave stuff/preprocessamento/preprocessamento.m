function [X, y] = preprocessamento(arquivo_csv)
  #colunas_texto = carregar_colunas(arquivo_csv);
  #[X, y] = converter_colunas(eval("colunas_texto", "[]"));
  [faltantes_linhas, faltantes_colunas] = analisar_faltantes(eval("X", "[]"));
  #[X, y, colunas_removidas] = remover_dados(eval("X", "[]"), eval("y", "[]"), ...
  #  eval("faltantes_linhas", "[]"), eval("faltantes_colunas", "[]"));  
  #X = preencher_faltantes(eval("X", "[]"));
  #X = normalizar_dados(eval("X", "[]"));
end  