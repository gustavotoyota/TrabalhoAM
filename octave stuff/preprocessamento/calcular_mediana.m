function mediana = calcular_mediana(valores)
  qtd_valores = prod(size(valores));
  
  # Ordenar valores
  valores = sort(valores);
  
  # Calcular mediana
  if mod(qtd_valores, 2) == 0
    esquerdo = valores(qtd_valores / 2);
    direito = valores(qtd_valores / 2 + 1);
    mediana = (esquerdo + direito) / 2;
  else
    mediana = valores((qtd_valores + 1) / 2);
  end
end  