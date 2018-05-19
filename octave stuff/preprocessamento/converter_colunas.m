function [X, y] = converter_colunas(colunas_texto)  
	printf("Convertendo colunas para valores num�ricos.\n");
  
  if isempty(colunas_texto)
    load("-binary", "preprocessamento/carregar_colunas.mat", "colunas_texto");
  end
  
	num_colunas = size(colunas_texto, 2);
  num_linhas = size(colunas_texto{1}, 1);
  
  # Convertendo atributos
	printf("- Convertendo atributos para valores num�ricos.\n");
  
  num_atributos = num_colunas - 1;
  
  X = zeros(num_linhas, num_atributos);
  
  max_duracoes = 10;
  duracao_acumulada = 0;
  duracoes = zeros(max_duracoes, 1);
  numero_duracao = 1;
	tempo_anterior = time();
	
	for atributo = 1 : num_atributos
		printf("  - Convertendo atributo %d.", atributo);
    
		coluna_texto = colunas_texto{atributo + 1};
		
		for linha = 1 : num_linhas
			valor = coluna_texto{linha};
			
			if strcmp(valor, "na")
				X(linha, atributo) = -1;
      else
				X(linha, atributo) = str2num(valor);
			end
		end
		
    tempo_atual = time();
    duracao_atual = tempo_atual - tempo_anterior;
    indice_duracao = mod(numero_duracao - 1, max_duracoes) + 1;
    duracao_acumulada = duracao_acumulada - duracoes(indice_duracao);
    duracoes(indice_duracao) = duracao_atual;
    duracao_acumulada = duracao_acumulada + duracao_atual;
    qtd_duracoes = min(numero_duracao, max_duracoes);
    tempo_restante = duracao_acumulada * (num_atributos - atributo) / qtd_duracoes;
    numero_duracao = numero_duracao + 1;
    tempo_anterior = tempo_atual;
    
    printf(" Tempo restante estimado: %.2f segundos.\n", tempo_restante);
	end
  
  # Convertendo sa�das
	printf("Convertendo sa�das para valores num�ricos.\n");
  
  y = zeros(num_linhas, 1);
  
  coluna_texto = colunas_texto{1};
  
  for i = 1 : num_linhas
    valor = coluna_texto{i};
    
    if strcmp(valor, "pos")
      y(i) = 1;
    else
      y(i) = 0;
    end
  end
  
  save("-binary", "preprocessamento/converter_colunas.mat", "X", "y");
end  