function [X] = preencher_faltantes(X)
  printf("Preenchendo faltantes com a mediana.\n");
  
  # Carregar inputs
  if isempty(X)
    load("-binary", "remover_dados.mat", "X");
  end
  
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  max_duracoes = 10;
  duracao_acumulada = 0;
  duracoes = zeros(max_duracoes, 1);
  numero_duracao = 1;
	tempo_anterior = time();
  
  for coluna = 1 : num_colunas
    printf("- Preenchendo coluna %d.", coluna);
      
    # Calcular mediana
    mediana = calcular_mediana_coluna(X(:, coluna));
    
    # Preencher faltantes com a mediana
    for linha = 1 : num_linhas
      if X(linha, coluna) < 0
        X(linha, coluna) = mediana;
      end
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
  save("-binary", "preencher_faltantes.mat", "X");
end  