function [faltantes_linhas, faltantes_colunas] = analisar_faltantes(X)
  printf("Analisando dados faltantes.\n");
  
  if isempty(X)
    load("-binary", "preprocessamento/converter_colunas.mat", "X");
  end
  
  num_linhas = size(X, 1);
  num_colunas = size(X, 2);
  
  faltantes_linhas = zeros(num_linhas, 1);
  faltantes_colunas = zeros(num_colunas, 1);
  
  max_duracoes = 5000;
  duracao_acumulada = 0;
  duracoes = zeros(max_duracoes, 1);
  numero_duracao = 1;
	tempo_anterior = time();
  
  for linha = 1 : num_linhas
    if mod(linha, 500) == 0
      printf("Analisando linha %d.", linha);
    end  
    
    for coluna = 1 : num_colunas
      if X(linha, coluna) < 0
        faltantes_linhas(linha) = faltantes_linhas(linha) + 1;
        faltantes_colunas(coluna) = faltantes_colunas(coluna) + 1;
      end
    end
		
    tempo_atual = time();
    duracao_atual = tempo_atual - tempo_anterior;
    indice_duracao = mod(numero_duracao - 1, max_duracoes) + 1;
    duracao_acumulada = duracao_acumulada - duracoes(indice_duracao);
    duracoes(indice_duracao) = duracao_atual;
    duracao_acumulada = duracao_acumulada + duracao_atual;
    qtd_duracoes = min(numero_duracao, max_duracoes);
    tempo_restante = duracao_acumulada * (num_linhas - linha) / qtd_duracoes;
    numero_duracao = numero_duracao + 1;
    tempo_anterior = tempo_atual;
    
    if mod(linha, 500) == 0
      printf(" Tempo restante estimado: %.2f segundos.\n", tempo_restante);
    end
  end  
  
  save("-binary", "preprocessamento/analisar_faltantes.mat", "faltantes_linhas", "faltantes_colunas");
end