function X = normalizar_dados(X)
  printf("Normalizando dados.\n");
  
  # Carregar inputs
  if isempty(X)
    load("-binary", "preencher_faltantes.mat", "X");
  end
  
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  max_duracoes = 10;
  duracao_acumulada = 0;
  duracoes = zeros(max_duracoes, 1);
  numero_duracao = 1;
	tempo_anterior = time();
  
  for coluna = 1 : num_colunas
    printf("- Normalizando coluna %d.", coluna);
    
    # Calcular média
    media = calcular_media(X(:, coluna));
    
    # Calcular desvio padrão
    desvio_padrao = calcular_desvio_padrao(X(:, coluna), media);
    
    # Normalizar coluna
    for linha = 1 : num_linhas
      X(linha, coluna) = (X(linha, coluna) - media) / desvio_padrao;
    end
    
    tempo_atual = time();
    duracao_atual = tempo_atual - tempo_anterior;
    indice_duracao = mod(numero_duracao - 1, max_duracoes) + 1;
    duracao_acumulada = duracao_acumulada - duracoes(indice_duracao);
    duracoes(indice_duracao) = duracao_atual;
    duracao_acumulada = duracao_acumulada + duracao_atual;
    qtd_duracoes = min(numero_duracao, max_duracoes);
    tempo_restante = duracao_acumulada * (num_colunas - coluna) / qtd_duracoes;
    numero_duracao = numero_duracao + 1;
    tempo_anterior = tempo_atual;
    
    printf(" Tempo restante estimado: %.2f segundos.\n", tempo_restante);
  end
  
  # Salvar outputs
  save("-binary", "normalizar_dados.mat", "X");
end