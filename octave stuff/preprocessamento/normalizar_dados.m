function X = normalizar_dados(X)
  printf("Normalizando dados.\n");
  
  # Carregar inputs
  if isempty(X)
    load("-binary", "preprocessamento/preencher_faltantes.mat", "X");
  end
  
  # Normalizar dados
  num_linhas = size(X, 1);
  
  medias = sum(X ./ num_linhas, 1);
  desvios_padroes = sqrt(sum(((X - medias) .^ 2) ./ num_linhas));
  X = (X - medias) ./ desvios_padroes;
  
  # Salvar outputs
  save("-binary", "preprocessamento/normalizar_dados.mat", "X", "medias", "desvios_padroes");
end