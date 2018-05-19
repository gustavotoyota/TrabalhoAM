function desvio_padrao = calcular_desvio_padrao(valores, media)
  variancia = 0;
  
  total_valores = prod(size(valores));
  
  soma_acumulada = 0;
  
  indice_valor = 1;
  
  while indice_valor <= total_valores
    while soma_acumulada < total_valores && indice_valor <= total_valores
      soma_acumulada = soma_acumulada + (valores(indice_valor) - media) ^ 2;
      
      indice_valor = indice_valor + 1;
    end
    
    variancia = variancia + soma_acumulada / total_valores;
    soma_acumulada = 0;
  end
  
  desvio_padrao = sqrt(variancia);
end