function [X, y] = converter_colunas(colunas_texto)  
  if isempty(colunas_texto)
    load("-binary", "carregar_colunas.mat", "colunas_texto");
  end
  
	num_colunas = size(colunas_texto, 2);
  num_linhas = size(colunas_texto{1}, 1);
  
  # Convertendo atributos
	printf("Convertendo atributos para valores numéricos.\n");
  
  num_atributos = num_colunas - 1;
  
  X = zeros(num_linhas, num_atributos);
  
	tempo_inicial = time();
	
	for atributo = 1 : num_atributos
    coluna = atributo + 1;
    
		printf("- Convertendo atributo %d.", atributo);
		
		if i > 2
			tempo_restante = (time() - tempo_inicial) * (num_atributos - atributo) / atributo;
			printf(" Tempo restante estimado: %.2f segundos.", tempo_restante);
		end
		
		printf("\n");
		
		coluna_texto = colunas_texto{coluna};
		
		for linha = 1 : num_linhas
			valor = coluna_texto{linha};
			
			if strcmp(valor, "na")
				X(linha, atributo) = -1;
      else
				X(linha, atributo) = str2num(valor);
			end
		end
	end
  
  # Convertendo saídas
	printf("Convertendo saídas para valores numéricos.\n");
  
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
  
  save("-binary", "converter_colunas.mat", "X", "y");
	
	printf("Conversão para valores numéricos finalizada.\n");
end  