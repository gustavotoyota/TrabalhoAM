function [X, y, colunas_removidas] = remover_dados(X, y, faltantes_linhas, faltantes_colunas)
  printf("Removendo dados.\n");
  
  # Carregar inputs
  if isempty(X)
    load("-binary", "preprocessamento/converter_colunas.mat", "X", "y");
  end
  if isempty(faltantes_linhas)
    load("-binary", "preprocessamento/analisar_faltantes.mat", "faltantes_linhas", "faltantes_colunas");
  end
  
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  threshold_linha = 10 * num_colunas / 100;
  threshold_coluna = 20 * num_linhas / 100;
  
  # Remover colunas
  printf("- Removendo colunas.\n");
  
  colunas_removidas = [];
  
  for coluna = num_colunas : -1 : 1
    if faltantes_colunas(coluna) >= threshold_coluna
      X(:, coluna) = [];
      colunas_removidas(end + 1) = coluna;
    end
  end
  
  # Remover linhas
  printf("- Removendo linhas.\n");
  
  max_duracoes = 5000;
  duracao_acumulada = 0;
  duracoes = zeros(max_duracoes, 1);
  numero_duracao = 1;
	tempo_anterior = time();
  
  for linha = num_linhas : -1 : 1
    if mod(linha, 500) == 0
      printf("  - Removendo linha %d.", linha);
    end
    
    if faltantes_linhas(linha) >= threshold_linha
      X(linha, :) = [];
    end
    
    tempo_atual = time();
    duracao_atual = tempo_atual - tempo_anterior;
    indice_duracao = mod(numero_duracao - 1, max_duracoes) + 1;
    duracao_acumulada = duracao_acumulada - duracoes(indice_duracao);
    duracoes(indice_duracao) = duracao_atual;
    duracao_acumulada = duracao_acumulada + duracao_atual;
    qtd_duracoes = min(numero_duracao, max_duracoes);
    tempo_restante = duracao_acumulada * (linha - 1) / qtd_duracoes;
    numero_duracao = numero_duracao + 1;
    tempo_anterior = tempo_atual;
    
    if mod(linha, 500) == 0
      printf(" Tempo restante estimado: %.2f segundos.\n", tempo_restante);
    end
  end
  
  # Salvar outputs
  save("-binary", "preprocessamento/remover_dados.mat", "X", "y", "colunas_removidas");
end  