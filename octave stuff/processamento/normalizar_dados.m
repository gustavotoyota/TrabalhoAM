function X = normalizar_dados(X)
  printf("Normalizando dados.");
  
  # Carregar inputs
  if isempty(X)
    load("-binary", "preencher_faltantes.mat", "X");
  end
  
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  for coluna = 1 : num_colunas
    # Calcular médias
    medias = calcular_medias(X);
    
    # Calcular desvios padrões
    desvios_padroes = calcular_desvios_padroes(X);
  end
  
  # Salvar outputs
  save("-binary", "normalizar_dados.mat", "X");
end