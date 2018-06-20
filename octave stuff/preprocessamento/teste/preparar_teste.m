% Prepara a base de teste usando os outputs do preprocessamento

% ENTRADA
%   arquivo_csv = nome do arquivo com os testes

% SAIDA
%   X = [MxN] base de teste preparada
%   y = [Mx1] rotulos da base de teste

function [X, y] = preparar_teste(arquivo_csv)
  colunas_texto = carregar_colunas(arquivo_csv, 'teste');
  [X, y] = converter_colunas(eval('colunas_texto', '[]'), 'teste');
  X = remover_outliers_test(eval('X', '[]'));
  [X, y] = remover_dados_test(eval('X', '[]'), eval('y', '[]'), 10, 50);
  [X, y] = balancear_classes_test(eval('X','[]'), eval('y','[]'));
  X = preencher_faltantes_test(eval('X', '[]'));
  X = normalizar_dados_test(eval('X', '[]'));
end