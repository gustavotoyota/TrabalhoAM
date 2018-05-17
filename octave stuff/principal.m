#clear all;
#clc;

more off;

#colunas_texto = carregar_colunas('aps_failure_training_set.csv');
#[X, y] = converter_colunas(eval("colunas_texto", "[]"));
[faltantes_linhas, faltantes_colunas] = analisar_faltantes(eval("X", "[]"));