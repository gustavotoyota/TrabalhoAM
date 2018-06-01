function [colunas_texto] = carregar_colunas_test(arquivo_csv)
  fprintf('Carregando colunas da base de dados.\n', i);
  
  num_colunas = 171;
	colunas_texto = cell(1, num_colunas);
	[colunas_texto{:}] = textread(arquivo_csv, repmat('%s', [1, num_colunas]), 'Delimiter', ',');
  
  save('preprocessamento/carregar_colunas_test.mat', 'colunas_texto', '-mat');
end