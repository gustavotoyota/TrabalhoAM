#clear all;
#clc;

opt = @(var_name) eval(var_name);

more off;

#colunas_texto = carregar_colunas('aps_failure_training_set.csv');
#[X, y] = converter_colunas(eval("colunas_texto", "[]"));
#[faltantes_linhas, faltantes_colunas] = analisar_faltantes(opt("X"));
[X, y, colunas_removidas] = remover_dados(eval("X", "[]"), eval("y", "[]"), ...
  eval("faltantes_linhas", "[]"), eval("faltantes_colunas", "[]"));  