#clear all;
#clc;

iif = @(varargin) varargin{2 * find([varargin{1:2:end}], 1, "first")};
optional = @(varname, default) iif(exist(varname), eval(varname, "1"), 1, default);

more off;

#colunas_texto = carregar_colunas('aps_failure_training_set.csv');
[X, y] = converter_colunas(optional("colunas_texto", []));