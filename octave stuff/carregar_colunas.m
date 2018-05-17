function colunas = carregar_colunas(arquivo_csv)
  printf("Carregando colunas da base de dados.\n", i);
  
  num_colunas = 171;
	colunas = cell(1, num_colunas);
	[colunas{:}] = textread(arquivo_csv, repmat('%s', [1, num_colunas]), 'Delimiter', ',');
  
  save("-binary", "carregar_colunas.mat", "colunas");
end