function mediana = calcular_mediana_coluna(valores)
  # Ordenar valores
  valores = sort(valores);
  
  # Encontrar primeiro valor positivo
  inicio = 1;
  while valores(inicio) < 0
    inicio = inicio + 1;
  end
  
  # Calcular mediana
  tamanho = size(valores, 1) - inicio + 1;
  if mod(tamanho, 2) == 0
    mediana = valores(tamanho / 2);
  else
    esquerdo = valores((tamanho - 1) / 2);
    direito = valores((tamanho + 1) / 2);
    
    mediana = (esquerdo + direito) / 2;
  end
end  