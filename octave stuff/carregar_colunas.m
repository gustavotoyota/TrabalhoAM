function colunas = carregar_colunas(nome_arquivo)
  printf("Carregando colunas da base de dados.\n", i);
  
  num_colunas = 171;
	colunas = cell(1, num_colunas);
	[colunas{:}] = textread(nome_arquivo, repmat('%s', [1, num_colunas]), 'Delimiter', ',');
  
  save("-binary", "dados.mat", "colunas");
end